#include <iostream.h>
#include <string.h>
#include <stdlib.h>

class Time {
private:
  unsigned hour;
  unsigned min;
  unsigned sec;
  //display an error message if the time format or the given time by the user is invalid
  void errmsg(const char* msg);
  //set this object to specified time, also added int &err parameter as a means of error catching
  void set(const char* hr_min_sec);

public:
  //print this time to stdout
  void display(void) const;
  //member function to add two Time objects 
  Time add(Time t1, Time t2);
  //overload the + operator to do Time + Time
  friend Time operator+(Time t1, Time t2);
  //overload the += operator to add two Time objects, t1+=t2 & t2+="12:30:00"
  Time& operator+= (const Time t);
  Time& operator+= (char* hhmmss);
  //overload the = operator to do assignment, t1=t2 & t2="12:30:00"
  Time& operator= (const Time t);
  Time& operator= (char* hhmmss);
  //overload >> operator to read in "hrs:min:sec" from in and set the Time to that value
  friend istream& operator>> (istream &in, Time &t);
  //overload << operator to forman and print out Time as hrs:min:sec
  friend ostream& operator<< (ostream &out, const Time &t);
  //declare some functions to get hour, min, sec values of a Time object
    unsigned gethour(void) const;
    unsigned getmin(void) const;
    unsigned getsec(void) const;
  //default constructor to set the Time object to 12:00:00
  Time(){hour = 12; min = 00; sec = 00;};
  //copy constructor
  Time(const Time &t);
  //overloaded constructor
  Time(const char* hh_mm_ss);
  //deconstructor
  ~Time();
    
};
//some member functions to get the hour, min, sec values of a Time object
unsigned Time::gethour(void) const{
    return hour;}
unsigned Time::getmin(void) const{
    return min;}
unsigned Time::getsec(void) const{
    return sec;}

//copy constructor definition
Time::Time(const Time &t)
{
    hour = t.gethour();
    min = t.getmin();
    sec = t.getsec();
//    cout << "The Time copy constructor is called now\n";
}
//overloaded constuctor definition
Time::Time(const char* hr_min_sec)
{
	char* temp;
	char copy[9];
	// assume user enters time as hr:min:sec
	if (strlen(hr_min_sec) != 8) errmsg(hr_min_sec);
	// use a copy of hr_min_sec	
	strcpy(copy,hr_min_sec);
	// parse the time and get the min
	temp = strtok(copy,":");		
	if (temp != NULL) hour = atoi(temp);		
	else errmsg(copy);  	
	if (hour < 0 || hour > 23) errmsg(hr_min_sec);     	  
	// parse the time and get the hour
	temp = strtok(NULL,":");	
	if (temp != NULL) min = atoi(temp);
	else errmsg(copy);
	if (min < 0 || min > 59) errmsg(hr_min_sec);	
	// parse the time and get the sec
	temp = strtok(NULL,":");
	if (temp != NULL) sec = atoi(temp);
	else errmsg(copy);
	if (sec < 0 || sec > 59) errmsg(hr_min_sec);
}
//destructor definition
Time::~Time()
{
//    cout << "The Time destructor is called now\n";
}
//this member function will be used for adding two Time objects
Time Time::add (Time t1, Time t2)
{
    Time res;
    unsigned hrs=0, mins=0, secs=0;
    secs = t1.sec + t2.sec;

    mins = t1.min + t2.min;
    if  (secs >= 60) mins++;

    hrs =  t1.hour +  t2.hour;
    if (mins >= 60) hrs++;

    res.hour = hrs%24;
    res.min = mins%60;
    res.sec = secs%60;
    return res;
}
//overloaded + operator for Time + Time
Time operator+(Time t1, Time t2)
{
    Time res;
    unsigned hrs=0, mins=0, secs=0;
    secs = t1.sec + t2.sec;

    mins = t1.min + t2.min;
    if  (secs >= 60) mins++;

    hrs =  t1.hour +  t2.hour;
    if (mins >= 60) hrs++;

    res.hour = hrs%24;
    res.min = mins%60;
    res.sec = secs%60;
    return res;
}
//add two Time objects of form time1 += time2
Time& Time::operator+= (const Time t)
{
    //get data values of current object
    Time tmp(*this);
    //re-use the add function to add the two Time objects
    tmp = add(tmp, t);
    //get new data values into current object
    hour = tmp.hour;
    min = tmp.min;
    sec = tmp.sec;
}
//add two Time objects of form time1 += "12:00:00"
Time& Time::operator+= (char* hhmmss)
{
    Time tmp(*this), t;
    //must get hhmmss into a Time t
    t.set(hhmmss);
    tmp = add(tmp, t);
    hour = tmp.hour;
    min = tmp.min;
    sec = tmp.sec;
}
//assign Time time1 = time2
Time& Time::operator= (const Time t)
{
    hour = t.hour;
    min = t.min;
    sec = t.sec;
}
//assign Time t1 = "12:00:00"
Time& Time::operator= (char* hhmmss)
{
    Time tmp;
    //get hhmmss into a Time object
    tmp.set(hhmmss);
    hour = tmp.hour;
    min = tmp.min;
    sec = tmp.sec;
}
//overloaded >> operator to get a Time object from istream in
istream& operator>>(istream &in, Time &t)
{
    char hour_min_sec[9];
    in >> hour_min_sec;
    //re-use the set function to do the actual work
    t.set(hour_min_sec);
    return in;
}

ostream&  operator<<(ostream &out, const Time &t)
{
    //format the ostream out
    out << t.hour << ':' << t.min << ':'<< t.sec << endl;;
    return out;
}

void Time::set(const char* hr_min_sec)
{
    if(strlen(hr_min_sec) != 8)
    {
      errmsg(hr_min_sec);
    }
  else
    {
      char* pch;
      int i, len;
      len = strlen(hr_min_sec) + 1;
      //first make a copy of the incomming string
      char* copy = new char[len];
      strcpy(copy, hr_min_sec);

      //parse string to get the hours
      pch = strtok(copy,":");
      if(strlen(pch) < 2)
	{
	  errmsg(hr_min_sec);
	}
      else
	{
	  //get and assign the integer value of hour, making sure it is less than 24
	  i = atoi(pch);
	  if(i < 24)
	    {
	      hour = i;

	      //parse string to get the minutes
	      pch = strtok(NULL,":");
	      if(strlen(pch) < 2)
		{
		  errmsg(hr_min_sec);
		}
	      else
		{
		  //get and assign the integer value of min, making sure it is less than 60
		  i = atoi(pch);
		  if(i < 60)
		    {
		      min = i;

		      //parse string to get the seconds
		      pch = strtok(NULL,":");
		      if(strlen(pch) < 2)
			{
			  errmsg(hr_min_sec);
			}
		      else
			{
			  //get and assign the integer value of sec, making sure it is less than 60
			  i = atoi(pch);
			  if(i < 60)
			    {
			      sec = i;
			    }
			  else
			    {
			      errmsg(hr_min_sec);
			    }
			}
		    }
		  else
		    {
		      errmsg(hr_min_sec);
		    }
		}
	    }
	  else
	    {
	      errmsg(hr_min_sec);
	    }
	}


      delete [] copy;
    }
}
  	
void Time::display(void) const
{
	cout << hour << ':' << min << ':'<< sec << endl;
	return;
}

void Time::errmsg(const char* msg)
{
	cerr << "Invalid time format: " << msg << endl;
}
//--------------------------------Class - DateTime ---------------------------------
class DateTime:public Time
{
private:
    int month, day, year;

public:
    DateTime(); //Default Constructor
    DateTime(int month, int day, int year, const char* hh_mm_ss); //constructor
    void setMonth(int month);
    void setDay(int day);
    void setYear(int year);
    void display() const; //display the date and time
};

DateTime::DateTime(int m, int d, int y, const char* hh_mm_ss):Time(hh_mm_ss)
{
//initialize the remaining variables
    month = m;
    day = d;
    year = y;
}

void DateTime::display() const
{
    //display the date and time
    cout << "The Date and Time is: " << month << '/' << day << '/' << year << ' ' << (Time&)(*this) << '\n';
}

void DateTime::setMonth(int m)
{
    month = m;
}

void DateTime::setDay(int d)
{
    day = d;
}

void DateTime::setYear(int y)
{
    year = y;
}

//---------------------------------New Main-----------------------------------------
int main()
{
    DateTime dt1(11,23,2002,"09:00:00");
    DateTime dt2(11,23,2002,"00:30:30");
    Time t3;
    
    cout << "dt1 = ";
    dt1.display();
//     cout << "dt2 = ";
//     dt2.display();
    dt1.setMonth(11);
    dt1.setDay(28);
    dt1.setYear(2002);
    cout << "now dt = ";
    dt1.display();
    t3 = (Time&)dt1 + (Time&)dt2;
    cout << "adding times of dt1 and dt2: " << t3 << '\n';
    
    return 0;
}

//---------------------------------Old Main-----------------------------------------
// int main(void)
// {
// 	Time t1, t;
// 	Time t2(t1);
// 	int menu = 0;

// 	cout << "What would you like to do?\n1.Enter Time t\n2.Add t to t1\n3.Assign t1 to t2\n4.Display t1, t2\n5.Quit\n";
// 	cin >> menu;
	
// 	while(menu !=5)
// 	{
// 	    if(menu == 1) // user selected menu option 1 - Enter Time t
// 	    {
// 	       	//char hour_min_sec[9];
// 	       	cout << "Enter the time <hr:min:sec> => ";
// 		//this will use the overloaded >> operator to get the
// 		//value of the input time into a Time object, t
// 	       	cin >> t;
// 	       	//t.set(hour_min_sec);
// 	    }
// 	    else if(menu == 2) //user selected menu option 2 - Add t to t1
// 	    {
// 		//as a test case i also tested the operation below,
// 		//and it works w/both good and bad data
// 		//t1 += "02:35:15";
// 		t1 += t;
// 	    }
// 	    else if(menu == 3) //user selected menu option 3 - Assign t1 to t2
// 	    {
// 		//as a test case i also tested the assignment below,
// 		//and it works w/both good and bad data	
// 		//t2 = "19:18:14";
// 		t2 = t1;
// 	    }
// 	    else //user selected menu option 4 - Display t1,t2
// 	    {
// 		cout << "t1's Time is: " << t1;
// 		//t1.display();
// 		cout << "t2's Time is: " << t2;
// 		//t2.display();
// 		//just for testing purposes
// 		//cout << "t's Time is: " << t;
// 	    }

// 	    cout << "What would you like to do?\n1.Enter Time t\n2.Add t to t1\n3.Assign t1 to t2\n4.Display t1, t2\n5.Quit\n";
// 	    cin >> menu;
// 	} //while(menu != 5)

// 	return 0;
// }
