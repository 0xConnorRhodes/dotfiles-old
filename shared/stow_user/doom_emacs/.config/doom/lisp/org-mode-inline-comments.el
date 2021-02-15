;;; Exporting
(add-hook 'org-export-before-parsing-hook #'aj/ox-inline-comment)

(defun aj/ox-inline-comment (backend)
  (when (member backend '(latex odt))
    (save-excursion
      (goto-char (point-min))
      (while (search-forward-regexp
              "❰\\(?3:\\[[^\]]+\\] \\)?\\(?1:[^❱❙]+\\)\\(?:❙\\(?3:\\[[^\]]+\\] \\)?\\(?2:[^❱]+\\)\\)?❱"
              nil t)
        (replace-match
         (cond
          ((eq 'latex backend)
           (let ((author (if (match-string 3)
                             (format "[author=%s]" (substring (match-string 3) 1 -2))
                           "")))
             (if (match-string 2)
                 (format "@@latex:\\fxnote*%s{%s}{%s}@@"
                         author (match-string 2) (match-string 1))
               (format "@@latex:\\fxnote%s{%s}@@" author (match-string 1)))))
          ((eq 'odt backend)
           (format (if (match-string 2)
                       (let ((an-name (concat "__Annot_" (number-to-string (random)))))
                         (format "@@odt:<office:annotation office:name=\"%s\"><dc:creator>%%s</dc:creator><dc:date>%%s</dc:date><text:list><text:list-item><text:p>%s</text:p></text:list-item></text:list></office:annotation>%s<office:annotation-end office:name=\"%s\"/>@@"
                                 an-name
                                 (match-string 2)
                                 (match-string 1)
                                 an-name))
                     (format "@@odt:<office:annotation><dc:creator>%%s</dc:creator><dc:date>%%s</dc:date><text:list><text:list-item><text:p>%s</text:p></text:list-item></text:list></office:annotation>@@"
                             (match-string 1)))
                   (if (match-string 3) (substring (match-string 3) 1 -2) (user-full-name))
                   (aj/odt-timestamp))))
         nil t)))))


;;; Inserting
(bind-key "C-c C-ä" #'aj/org-insert-inline-comment org-mode-map)
(defun aj/org-insert-inline-comment (arg)
  (interactive "P")
  (if (use-region-p)
      (let ((beg (min (point) (mark))) 
            (end (max (point) (mark))))
        (goto-char beg)
        (insert "❰")
        (goto-char (1+ end))
        (insert (concat"❙"
                       (when arg (aj/org-inline-comment-name))   
                       "❱"))
        (backward-char))
    (insert (concat "❰"
                    (when arg (aj/org-inline-comment-name))
                    "❱"))
    (backward-char)))

(defvar aj/org-inline-comment-name-history nil)

(defun aj/org-inline-comment-name ()
  (concat
   "["
   (helm :sources '(aj/org-inline-comment-names-source
                    aj/org-inline-comment-names-fallback-source)
         :buffer "*aj helm choose oic-names*"
         :resume 'noresume
         :history 'aj/org-inline-comment-name-history)
   ;; (helm-comp-read
   ;;  "Författare: "
   ;;  aj/org-insert-inline-comment-name-history
   ;;  :input-history 'aj/org-insert-inline-comment-name-history
   ;;  :name "Comment name" :buffer "*oic-helm*")
   "] "))


(defvar aj/org-inline-comment-names-source
  (helm-build-sync-source "Inline comment names"
    :candidates 'aj/org-inline-comment-name-history
    :fuzzy-match t
    :action (helm-make-actions "Insert" 'identity "Delete" 'aj/org-inline-comment-remove-name)
    :persistent-action 'aj/org-inline-comment-remove-name
    :multiline t)
  "Source for inline comment names")

(defvar aj/org-inline-comment-names-fallback-source
  '((name . "Insert")
    (dummy)
    (action . (("insert" . identity)))))

(defun aj/org-inline-comment-remove-name (_cand)
  (let ((marked (helm-marked-candidates)))
    (dolist (el marked)
      (setq aj/org-inline-comment-name-history
            (delete el aj/org-inline-comment-name-history))))
  (helm-force-update))

(font-lock-add-keywords 'org-mode '(("❰\\(\\[[^\]]+\\] \\)?\\([^❱❙]+\\)❱"
                                     (1 'bold prepend t)
                                     (2 'helm-buffer-process prepend))
                                    ("❰\\([^❱❙]+\\)❙\\(\\[[^\]]+\\] \\)?\\([^❱]+\\)❱" 
                                     (1 'org-target prepend)
                                     (2 'bold prepend t)
                                     (3 'helm-buffer-process prepend))))

