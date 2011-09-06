require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Comalisp" do
  context "list:" do
    it "is a cons" do
      (ComaLisp {
         (consp (list 1, 2))
       }).should be_true
    end

    specify "car is 1" do
      (ComaLisp {
         (car (list 1, 2))
       }).should == 1
    end

    it "cadr element is 2" do
      (ComaLisp {
         (car (cdr (list 1, 2)))
       }).should == 2
    end
  end

  context "cons:" do
    it "builds a cons" do
      (ComaLisp {
         (consp (cons 1, null))
       }).should == true
    end

    it "takes the car" do
      (ComaLisp {
         (car (cons 1, null))
       }).should == 1
    end

    it "the cdr of a one element list is null" do
      (ComaLisp {
         (nullp (cdr (cons 1, null)))
       }).should be_true
    end

    specify "the cdr of null is null" do
      (ComaLisp {
         (nullp (cdr null))
       }).should be_true
    end

    specify "car of null is null" do
      (ComaLisp {
         (nullp (car null))
       }).should be_true
    end
  end

  context "let:" do
    specify "variable binding" do
      (ComaLisp {
         (let [:a,1], [:b,2] {
           [a,b]
         })}).should == [1,2]
    end

    specify "variable shadow" do
      (ComaLisp {
         (let [:a,1], [:b,2] {
            (let [:a,3] {
               [a,b]
             })})}).should == [3,2]
    end
  end

  context "set:" do
    it "sets a binding" do
      (ComaLisp {
         (let [:a,1] {
            (set :a, 2)
            a
          })}).should == 2
    end
  end

  context "defun:" do
    specify "define local function" do
      (ComaLisp {
         (defun [:foo,:a,:b] {
            [a,b]})
         [(foo 1, 2),(foo 3, 4)]}).should == [[1,2],[3,4]]
    end
  end

  context "method prefixing:" do
    it "calls the method on the first argument" do
      (ComaLisp {
         (map [-1,-2,-3] { |e|
            (abs e)})}).should == [1,2,3]
    end
  end
end
