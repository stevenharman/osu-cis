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
//   class Regular : public Special;

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
};


class Quote : public Special {
 private:
  // TODO: Add any fields needed.

 public:
  // TODO: Add an appropriate constructor.

  virtual void print(Node * t, int n, bool p);
};


class Lambda : public Special {
 private:
  // TODO: Add any fields needed.

 public:
  // TODO: Add an appropriate constructor.

  virtual void print(Node * t, int n, bool p);
};


class Begin : public Special {
 private:
  // TODO: Add any fields needed.

 public:
  // TODO: Add an appropriate constructor.

  virtual void print(Node * t, int n, bool p);
};


class If : public Special {
 private:
  // TODO: Add any fields needed.

 public:
  // TODO: Add an appropriate constructor.

  virtual void print(Node * t, int n, bool p);
};


class Let : public Special {
 private:
  // TODO: Add any fields needed.

 public:
  // TODO: Add an appropriate constructor.

  virtual void print(Node * t, int n, bool p);
};


class Cond : public Special {
 private:
  // TODO: Add any fields needed.

 public:
  // TODO: Add an appropriate constructor.

  virtual void print(Node * t, int n, bool p);
};


class Define : public Special {
 private:
  // TODO: Add any fields needed.

 public:
  // TODO: Add an appropriate constructor.

  virtual void print(Node * t, int n, bool p);
};


class Set : public Special {
 private:
  // TODO: Add any fields needed.

 public:
  // TODO: Add an appropriate constructor.

  virtual void print(Node * t, int n, bool p);
};


class Regular : public Special {
 private:
  // TODO: Add any fields needed.

 public:
  // TODO: Add an appropriate constructor.

  virtual void print(Node * t, int n, bool p);
};

#endif SPECIAL_H
