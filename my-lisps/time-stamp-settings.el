;; Time-stamp: <2011-02-12 14:57:21 Saturday by tyraeltong>

(add-hook 'write-file-hooks 'time-stamp)

(eval-after-load "time-stamp"
  '(progn
     (setq time-stamp-format "%04y-%02m-%02d %02H:%02M:%02S %:a by %u")))

(provide 'time-stamp-settings)