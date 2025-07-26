(require :cl-raylib)

(defpackage :game-main
  (:use :cl :raylib :3d-vectors))

(in-package :game-main)

(defconstant +camera+ (make-camera3d :position (vec3 0 10 10) :target (vec3) :fovy 45 :up (vec3 0 1 0) :projection  :camera-perspective))

(defun main ()
  (let ((screen-width 800)
        (screen-height 450)
        (position (vec 0 0 0)))
    (with-window (screen-width screen-height "raylib [core] example - basic window")
      (set-target-fps 60) ; Set our game to run at 60 FPS
      (loop until (window-should-close) ; detect window close button or ESC key
            do
               (setq position (update-position position))
               (with-drawing
                 (clear-background :raywhite)
                 (draw-fps 20 20)
                 (with-mode-3d (+camera+)
                   (draw-cube-v position (vec 1 1 1) :skyblue)))
            ))))

(defun update-position (position)
  (let ((new-position position))
    (if (is-key-down :key-w)
        (incf (vz new-position) -0.5))
    (if (is-key-down :key-s)
        (incf (vz new-position) 0.5))
    (if (is-key-down :key-a)
        (incf (vx new-position) -0.5))
    (if (is-key-down :key-d)
        (incf (vx new-position) 0.5))
    new-position))

(main)
