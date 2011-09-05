# ComaLisp: A Lispy Abuse of Ruby Syntax

    (ComaLisp {
       (let [:a,1], [:b, 2] {
          (defun [:foo,:a,:b,:c] {
             (let [:d, 6] {
                (list a, b, c, d)})})
          (p (list a, b, (foo 3, 4, 5)))})})


This is _VALID_ Ruby syntax under 1.9. I kid you not.