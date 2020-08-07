-- Ahmed Abd-Allah
-- CSCI 571, Fall 1993

-- FILE: TEXTPKG.ADA

-- this entire package is a copy more or less of the code distributed by Brad Clark

package TextPkg is

    -- Ada does not have variable length strings so one way to deal with
    -- this is to declare a string the size of the maximum string to be read.
    -- When the procedure Get_Line in package Text_IO gets a line of input
    -- either from a file or the terminal is also returns the number of
    -- characters read. This information should be saved as well. A 
    -- convenient data structure for this is the following:
  type Text(Max : Natural := 80) is record
	   Line : String(1..Max) := (others => ' ');
	   Len  : Natural := 0;
  end record;

  procedure Get_Word (Long_Str   :in out Text;  Word_Found :out Text);

end TextPkg;

package body TextPkg is

-- This procedure will look through Long_Str.Line
-- and put the first contiguous string of characters that are
-- not spaces or tabs into Word.Line with its length in Word.Len.
-- It will modify Long_Str.Line by removing the word found
-- thus shorting the length of Long_Str. This procedure 
-- should be called repeatedly until Word_Found.Len is zero.
--

procedure Get_Word (Long_Str   :in out Text;
		       Word_Found :out Text) is
    Tab : Character := ASCII.HT;
    W_Start, W_End, W_Len : Positive := 1;
begin

    if (Long_Str.Len <= 0) then
	   Word_Found.Len := 0;
    else
	   -- find the first non-space char / tab but don't look past
	   -- the end of Long_Str.Line
	   loop
	       exit when W_Start > Long_Str.Len;
	       exit when (Long_Str.Line(W_Start) /= ' ') and
			 (Long_Str.Line(W_Start) /= Tab);
	       W_Start := W_Start + 1;
	   end loop;

	   -- If no non-space char/ tab were found finish-up
	   if (W_Start > Long_Str.Len) then
	       Long_Str.Len := 0;
	       Word_Found.Len := 0;
	   else
	       -- find the next space char / tab but don't look past the
	       -- end of Long_Str.Line
	       W_End := W_Start;
	       loop
		   exit when W_End > Long_Str.Len;
		   exit when (Long_Str.Line(W_End) = ' ') or
			     (Long_Str.Line(W_End) = Tab);
		   W_End := W_End + 1;
	       end loop;

	       -- capture word and its length
	       W_Len := W_End - W_Start;
	       Word_Found.Line(1..W_Len) := Long_Str.Line(W_Start..(W_End - 1));
	       Word_Found.Len := W_Len;

	       -- adjust Long_String by slicing the array then adjust its length
	       Long_Str.Line(1..(Long_Str.Len - (W_End - 1))) :=
		   Long_Str.Line(W_End..Long_Str.Len);
	       Long_Str.Len := Long_Str.Len - (W_End - 1);
	   end if;
    end if;

end Get_Word;

end TextPkg;
