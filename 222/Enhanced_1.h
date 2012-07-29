//  /*-------------------------------------------------------------------*\
//  |   Concrete Template : List_Enhanced_1
//  \*-------------------------------------------------------------------*/

#ifndef CT_LIST_ENHANCED_1
#define CT_LIST_ENHANCED_1 1
 
///------------------------------------------------------------------------
/// Global Context --------------------------------------------------------
///------------------------------------------------------------------------

#include "AT/List/Enhanced.h"

///---------------------------------------------------------------------
/// Interface ----------------------------------------------------------
///---------------------------------------------------------------------

concrete_template <
	concrete_instance class Item,
	concrete_instance class Node,
	/*!
	    implements
		abstract_instance Record <
			Item,
			Node_Ptr,
			Node_Ptr,
			number_of_fields (3)
		    >
	!*/
	concrete_instance class Node_Ptr,
	/*!
	    implements
		abstract_instance Pointer <Node>
	!*/
	concrete_instance class Rep
	/*!
	    implements
		abstract_instance Representation <
			Node_Ptr,
			Node_Ptr,
			Node_Ptr,
			Integer,
			Integer,
			number_of_fields (5)
		    >
	!*/
    >
class List_Enhanced_1 :
    implements
	abstract_instance List_Enhanced <Item>,
    encapsulates
	concrete_instance Rep
	/*!
	    convention
                self.pre_start /= NULL  and
                self.last_left /= NULL  and
                self.post_finish /= NULL  and
		self.left_length >= 0  and
		self.right_length >= 0  and
		[self.pre_start points to the first node of a doubly-
		 linked list containing (self.left_length +
                 self.right_length + 2) Node nodes]  and 
                [self.last_left points to the (self.left_length + 1)-th
		 node in the doubly-linked list of nodes]  and
                [self.post_finish points to the last node in the
		 doubly-linked list of nodes]  and
		[for every node n in the doubly-linked list of nodes,
		 except the one pointed to by self.pre_start,
		 n.previous.next = n]  and
		[for every node n in the doubly-linked list of nodes,
		 except the one pointed to by self.post_finish,
		 n.next.previous = n]
		 
	    correspondence
		 self.left = 
                    <self.pre_start.next.data> *
		    <self.pre_start.next.next.data> *
		    ... *
		    <self.last_left.data>  and
		 self.right = 
                    <self.last_left.next.data> *
		    <self.last_left.next.next.data> *
		    ... *
		    <self.post_finish.previous.data>
	!*/
{
public:

    standard_concrete_operations (List_Enhanced_1);

    procedure Move_To_Start ();
    
    procedure Move_To_Finish ();
    
    procedure Advance ();

    procedure Retreat ();

    procedure Add_Right (
	    consumes Item& x
	);

    procedure Remove_Right (
	    produces Item& x
	);

    function Item& operator [] (
	    preserves Accessor_Position& current
	);

    function Integer Left_Length ();
    
    function Integer Right_Length ();

protected:

    procedure Initialize ();

    procedure Finalize ();

    // field names for Node
    
    field_name (Node, 0, Item, data);
    field_name (Node, 1, Node_Ptr, next);
    field_name (Node, 2, Node_Ptr, previous);

    // field names for Rep
    
    rep_field_name (Rep, 0, Node_Ptr, pre_start);
    rep_field_name (Rep, 1, Node_Ptr, last_left);
    rep_field_name (Rep, 2, Node_Ptr, post_finish);
    rep_field_name (Rep, 3, Integer, left_length);
    rep_field_name (Rep, 4, Integer, right_length);

};

#endif // CT_LIST_ENHANCED_1
