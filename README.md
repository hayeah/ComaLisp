Only works under Ruby 1.9

# Lisp and Ruby. Marriage Made In Hell

    (ComaLisp {
       (let [:a,1], [:b, 2] {
          (defun [:foo,:a,:b,:c] {
             (let [:d, 6] {
                (list a, b, c, d)})})
          (p (list a, b, (foo 3, 4, 5)))})})
          
This is _VALID_ Ruby syntax under 1.9.

Here is an [introduction to ComaLisp](http://metacircus.com/hacking/2011/09/07/lispy-abuse-of-ruby-syntax.html)

Feedback [@hayeah](http://twitter.com/hayeah)