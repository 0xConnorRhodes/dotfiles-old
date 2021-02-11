"""
    cutitout: automatically cut silence from videos
    Copyright (C) 2020 Wolf Clement

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published
    by the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
"""

# Margin before and after a clip (in seconds)
#clip_margin = 0.4
clip_margin = 0.2
assert clip_margin >= 0.0

# How loud should noise be to be considered a sound?
audio_treshold = 0.02
assert audio_treshold > 0.0 and audio_treshold <= 1.0

# Minimum clip length (in seconds)
# Sounds shorter than that will be considered noise and cut.
min_clip_length = 0.2
assert min_clip_length > 0.0

# Minimum silence length to skip (in seconds)
min_skip_length = 5.0
assert min_skip_length > 2 * clip_margin


import audioop
import subprocess
import sys


def get_audio_streams(filename):
    streams = []
    probe = subprocess.check_output(
        ["ffprobe", "-show_streams", filename],
        encoding="utf-8",
        stderr=subprocess.DEVNULL,
    )

    for line in probe.split("\n"):
        if line == "[STREAM]":
            streams.append({})

        try:
            key, value = line.split("=")
            streams[-1][key] = value
        except ValueError:
            pass

    return list(filter(lambda s: s["codec_type"] == "audio", streams))


def print_skips(stream, sample_rate):
    clips = []
    clip_index = 0
    loud_start = -1

    # Get 10ms long audio fragments (* 2 because we get 2 bytes)
    fragment_length = int(sample_rate * 0.01 * 2)

    chunk_data = orig_audio.stdout.read(fragment_length)
    while chunk_data:
        # With *signed* 16 bit audio, the maximal absolute value is 2^15 = 32768.
        volume = audioop.max(chunk_data, 2) / 32768

        if loud_start == -1 and volume >= audio_treshold:
            loud_start = clip_index
        elif loud_start != -1 and volume < audio_treshold:
            # Remove sounds that are too short to be important
            if clip_index - loud_start > min_clip_length * 100:
                clips.append((loud_start, clip_index))
            loud_start = -1

        chunk_data = orig_audio.stdout.read(fragment_length)
        clip_index += 1

    # Turn clips into skips
    skips = []
    last_skip = 0.0
    index_to_time = lambda index: index / 100
    for clip in clips:
        clip_start = index_to_time(clip[0])
        clip_end = index_to_time(clip[1])

        if clip_start - last_skip < min_skip_length:
            last_skip = clip_end + clip_margin
        else:
            skips.append((last_skip + clip_margin, clip_start - clip_margin))
            last_skip = clip_end + clip_margin

    skips = ["{" + f"{v[0]},{v[1]}" + "}" for v in skips]
    print("return {" + ",".join(skips) + "}")


for filename in sys.argv[1:]:
    for stream in get_audio_streams(filename):
        index = int(stream["index"])
        sample_rate = int(stream["sample_rate"])

        orig_audio = subprocess.Popen(
            [
                "ffmpeg",
                "-i",
                filename,
                # Output only one channel
                "-ac",
                "1",
                # Output raw 16bit samples for fast processing
                "-f",
                "s16le",
                # Open specific audio stream
                "-map",
                f"0:{index}",
                # Only use one core to avoid making mpv lag
                "-threads",
                "1",
                # Pipe to orig_audio
                "pipe:1",
            ],
            stdout=subprocess.PIPE,
            stderr=subprocess.DEVNULL,
        )

        print_skips(orig_audio.stdout, sample_rate)

        # We're only using the first audio stream
        break
