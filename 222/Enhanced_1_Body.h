//  /*-------------------------------------------------------------------*\
//  |   Concrete Template Body : List_Enhanced_1
//  \*-------------------------------------------------------------------*/

#ifndef CT_LIST_ENHANCED_1_BODY
#define CT_LIST_ENHANCED_1_BODY 1

///------------------------------------------------------------------------
/// Global Context --------------------------------------------------------
///------------------------------------------------------------------------

#include "CT/List/Enhanced_1.h"

///------------------------------------------------------------------------
/// Public Operations -----------------------------------------------------
///------------------------------------------------------------------------

concrete_template <
	concrete_instance class Item,
	concrete_instance class Node,
	concrete_instance class Node_Ptr,
	concrete_instance class Rep
    >
procedure_body List_Enhanced_1 <
	Item,
	Node,
	Node_Ptr,
	Rep
    > ::
    Move_To_Start ()
{
    //point self[last_left] to the smart node self[pre_start]
    self[last_left] = self[pre_start];

    //assign the correct values for the lengths
    self[right_length] += self[left_length];
    self[left_length] = 0;
}

//-------------------------------------------------------------------------

concrete_template <
	concrete_instance class Item,
	concrete_instance class Node,
	concrete_instance class Node_Ptr,
	concrete_instance class Rep
    >
procedure_body List_Enhanced_1 <
	Item,
	Node,
	Node_Ptr,
	Rep
    > ::
    Move_To_Finish ()
{
    //point self[last_left] to (*self[post_finish])[prev]
    self[last_left] = (*self[post_finish])[previous];

    //assign the correct values to the length variables
    self[left_length] += self[right_length];
    self[right_length] = 0;
    
}

//-------------------------------------------------------------------------

concrete_template <
	concrete_instance class Item,
	concrete_instance class Node,
	concrete_instance class Node_Ptr,
	concrete_instance class Rep
    >
procedure_body List_Enhanced_1 <
	Item,
	Node,
	Node_Ptr,
	Rep
    > ::
    Advance ()
{
    //point last_left to the node after itself
    self[last_left] = (*self[last_left])[next];

    //adjust the length variables accordingly
    self[left_length]++;
    self[right_length]--;
}

//-------------------------------------------------------------------------

concrete_template <
	concrete_instance class Item,
	concrete_instance class Node,
	concrete_instance class Node_Ptr,
	concrete_instance class Rep
    >
procedure_body List_Enhanced_1 <
	Item,
	Node,
	Node_Ptr,
	Rep
    > ::
    Retreat ()
{
    //point last_left to the node before itself
    self[last_left] = (*self[last_left])[previous];

    //adjust the length variable accordingly
    self[left_length]--;
    self[right_length]++;
}

//-------------------------------------------------------------------------

concrete_template <
	concrete_instance class Item,
	concrete_instance class Node,
	concrete_instance class Node_Ptr,
	concrete_instance class Rep
    >
procedure_body List_Enhanced_1 <
	Item,
	Node,
	Node_Ptr,
	Rep
    > ::
    Add_Right (
	    consumes Item& x
	)
{
    object Node_Ptr temp;
    New (temp);

    //swap x into the data field of the new node temp
    x &= (*temp)[data];

    //point next and previous pointers of the temp Node to the node
    //following self[last_left] and to self[last_left] itself
    (*temp)[next] = (*self[last_left])[next];
    (*temp)[previous] = self[last_left];

    //point the node at self[last_left] to the temp node
    (*(*self[last_left])[next])[previous] = temp;
    (*self[last_left])[next] = temp;

    self[right_length]++;
}

//-------------------------------------------------------------------------

concrete_template <
	concrete_instance class Item,
	concrete_instance class Node,
	concrete_instance class Node_Ptr,
	concrete_instance class Rep
    >
procedure_body List_Enhanced_1 <
	Item,
	Node,
	Node_Ptr,
	Rep
    > ::
    Remove_Right (
	    produces Item& x
	)
{
    object Node_Ptr temp;

    //point temp to the node after self[last_left]
    temp = (*self[last_left])[next];
    //point the next field of self[last_left] to temp[next]
    (*self[last_left])[next] = (*temp)[next];
    //point the previous field of the node after temp to self[last_left]
    (*(*temp)[next])[previous] = self[last_left];

    //swap the data out of the temp node
    x &= (*temp)[data];

    Delete (temp);

    self[right_length]--;
}

//-------------------------------------------------------------------------

concrete_template <
	concrete_instance class Item,
	concrete_instance class Node,
	concrete_instance class Node_Ptr,
	concrete_instance class Rep
    >
function_body Item& List_Enhanced_1 <
	Item,
	Node,
	Node_Ptr,
	Rep
    > ::
    operator [] (
	    preserves Accessor_Position& current
	)
{
    return (*(*self[last_left])[next])[data];   
}

//-------------------------------------------------------------------------

concrete_template <
	concrete_instance class Item,
	concrete_instance class Node,
	concrete_instance class Node_Ptr,
	concrete_instance class Rep
    >
function_body Integer List_Enhanced_1 <
	Item,
	Node,
	Node_Ptr,
	Rep
    > ::
    Left_Length ()
{
    return self[left_length];
}

//-------------------------------------------------------------------------

concrete_template <
	concrete_instance class Item,
	concrete_instance class Node,
	concrete_instance class Node_Ptr,
	concrete_instance class Rep
    >
function_body Integer List_Enhanced_1 <
	Item,
	Node,
	Node_Ptr,
	Rep
    > ::
    Right_Length ()
{
     return self[right_length];
}

//-------------------------------------------------------------------------

///------------------------------------------------------------------------
/// Protected Operations --------------------------------------------------
///------------------------------------------------------------------------

concrete_template <
	concrete_instance class Item,
	concrete_instance class Node,
	concrete_instance class Node_Ptr,
	concrete_instance class Rep
    >
procedure_body List_Enhanced_1 <
	Item,
	Node,
	Node_Ptr,
	Rep
    > ::
    Initialize ()
{
    //create new nodes at self[pre_start] and self[post_finish]
    New(self[pre_start]);
    New(self[post_finish]);

    //point the new nodes to each other and self[last_left] to self[pre_start]
    (*self[pre_start])[next] = self[post_finish];
    (*self[post_finish])[previous] = self[pre_start];
    self[last_left] = self[pre_start];
}

//-------------------------------------------------------------------------

concrete_template <
	concrete_instance class Item,
	concrete_instance class Node,
	concrete_instance class Node_Ptr,
	concrete_instance class Rep
    >
procedure_body List_Enhanced_1 <
	Item,
	Node,
	Node_Ptr,
	Rep
    > ::
    Finalize ()
{
     object Node_Ptr temp;

    temp = self[pre_start];

    //loop to ensure all nodes are deleted
    while (temp != self[post_finish])
    {
	self[pre_start] = (*self[pre_start])[next];
	Delete (temp);
	temp = self[pre_start];
    }//while(temp!= self[post_finish])
    
    Delete (temp);
}

//-------------------------------------------------------------------------

#endif // CT_LIST_ENHANCED_1_BODY
