// Special.h -- the parse tree node data structure for special forms
//
// Defines the types
//
//   class Special;
//   class Quote : public Special;
//   class Lambda : public Special;
//   class Begin : public Special;
//   class If : public Special;
//   class Let : public Special;
//   class Cond : public Special;
//   class Define : public Special;
//   class Set : public Special;
//   class Regular : public Special
class Environment;
#ifndef SPECIAL_H
#define SPECIAL_H

#include <iostream.h>
#include "Tree.h"

#ifndef NULL
#define NULL 0
#endif
#define FALSE 0
#define TRUE  1

class Special {
 public:
  virtual void print(Node * t, int n, bool p) = 0;
    //LAB #2
    virtual Node * eval(Node * p, Environment * env){return NULL; }
};

// The constructors of the following classes take a pointer to the
// cons node as argument that create the special node object.  This
// allows adding any necessary parsing code later.

class Quote : public Special {
 private:
  // TODO: Add any fields needed.

 public:
  Quote (Node * t) { }

  virtual void print(Node * t, int n, bool p);
    //LAB #2
    virtual Node * eval(Node * p, Environment * env);
};


class Lambda : public Special {
 private:
  // TODO: Add any fields needed.

 public:
  Lambda (Node * t) { }

  virtual void print(Node * t, int n, bool p);
    //LAB #2
    virtual Node * eval(Node * p, Environment * env);
};


class Begin : public Special {
 private:
  // TODO: Add any fields needed.

 public:
  Begin (Node * t) { }

  virtual void print(Node * t, int n, bool p);
    //LAB #2
    virtual Node * eval(Node * p, Environment * env);
    Node * eval_begin(Node * p, Environment * env);
};


class If : public Special {
 private:
  // TODO: Add any fields needed.

 public:
  If (Node * t) { }

  virtual void print(Node * t, int n, bool p);
    //LAB #2
    virtual Node * eval(Node * p, Environment * env);
};


class Let : public Special {
 private:
  // TODO: Add any fields needed.

 public:
  Let (Node * t) { }

  virtual void print(Node * t, int n, bool p);
    //LAB #2
    virtual Node * eval(Node * p, Environment * env);
    Node * eval_body(Node * p, Environment * env);
};


class Cond : public Special {
 private:
  // TODO: Add any fields needed.

 public:
  Cond (Node * t) { }

  virtual void print(Node * t, int n, bool p);
    //LAB #2
    virtual Node * eval(Node * p, Environment * env);
};


class Define : public Special {
 private:
  // TODO: Add any fields needed.

 public:
  Define (Node * t) { }

  virtual void print(Node * t, int n, bool p);
    //LAB #2
    virtual Node * eval(Node * p, Environment * env);
};


class Set : public Special {
 private:
  // TODO: Add any fields needed.

 public:
  Set (Node * t) { }

  virtual void print(Node * t, int n, bool p);
    //LAB #2
    virtual Node * eval(Node * p, Environment * env);
};


class Regular : public Special {
 private:
  // TODO: Add any fields needed.

 public:
  Regular (Node * t) { }

  virtual void print(Node * t, int n, bool p);
    //LAB #2
    virtual Node * eval(Node * p, Environment * env);
    Node * eval_list(Node * p, Environment * env);
};

#endif SPECIAL_H
