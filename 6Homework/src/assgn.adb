with Ada.Text_IO, Ada.Integer_Text_IO;
use Ada.Text_IO, Ada.Integer_Text_IO;
with Ada.Numerics.Discrete_Random;


package body Assgn is
   package Rand is new Ada.Numerics.Discrete_Random (BINARY_NUMBER);
   use Rand;

   procedure Init_Array (Arr: in out BINARY_ARRAY) is
      Gen: Generator;

   begin
      Reset(Gen);
      for i in Arr'range loop
         Arr(i) := Random(Gen);
      end loop;
   end Init_Array;

   procedure Reverse_Bin_Arr (Arr : in out BINARY_ARRAY) is
      temp : BINARY_NUMBER;
      i : INTEGER;

   begin
      i := 1;
      while i <= Arr'Length / 2 loop
         temp := Arr(i);
         Arr(i) := Arr(Arr'Length - i + 1);
         Arr(Arr'Length - i + 1) := temp;
         i := i + 1;
      end loop;
   end Reverse_Bin_Arr;

   procedure Print_Bin_Arr (Arr: in BINARY_ARRAY) is
   begin
      for i in Arr'range loop
         Put(String(Integer'Image(Integer(Arr(i)))));
      end loop;
      New_Line;
   end Print_Bin_Arr;

   function Int_To_Bin(Num : in INTEGER) return BINARY_ARRAY is
      Quotient: Integer := Num;
      Remainder: Integer;
      Result_Bin_Array: BINARY_ARRAY;

   begin
      for i in reverse Result_Bin_Array'range loop
         if Quotient = 0 then
            remainder := 0;
         else
            Remainder := Quotient mod 2;
            Quotient := Quotient / 2;
         end if;
         Result_Bin_Array(i) := BINARY_NUMBER(Remainder);
      end loop;
      return Result_Bin_Array;
   end Int_To_Bin;

   function Bin_To_Int (Arr : in BINARY_ARRAY) return INTEGER is
      Multiplier: Integer := 1;
      Result: Integer := 0;

   begin
      for i in reverse Arr'range loop
         Result := Result + Integer(Arr(i)) * Multiplier;
         Multiplier := Multiplier * 2;
      end loop;

      return Result;

   end Bin_To_Int;

   function "+" (Left, Right : in BINARY_ARRAY) return BINARY_ARRAY is

      Carry: Integer := 0;
      Result: BINARY_ARRAY;

   begin
      for i in reverse Left'range loop
         if Carry <= 0 then

            if Left(i) = 1 and Right(i) = 1 then
               Result(i) := BINARY_NUMBER(0);
               Carry := Carry + 1;

            elsif Left(i) = 0 and Right(i) = 0 then
               Result(i) := BINARY_NUMBER(0);

            else
               Result(i) := BINARY_NUMBER(1);

            end if;

         elsif Carry > 0 then
            if Left(i) = 1 and Right(i) = 1 then
               Result(i) := BINARY_NUMBER(1);

            elsif Left(i) = 0 and Right(i) = 0 then
               Result(i) := BINARY_NUMBER(1);
               Carry := Carry - 1;

            else
               Result(i) := BINARY_NUMBER(0);
            end if;
         end if;
      end loop;

      return Result;
   end "+";

   --overload "+"
   function "+" (Left_Int : in INTEGER; Right : in BINARY_ARRAY) return BINARY_ARRAY is
      Left: BINARY_ARRAY := Int_To_Bin(Left_Int);

   begin
      return Left + Right;
   end "+";

   function "-" (Left, Right : in BINARY_ARRAY) return BINARY_ARRAY is
      Borrow: Integer := 0;
      Result: BINARY_ARRAY;

   begin
      for i in reverse Left'range loop
         if Borrow <= 0 then
            if Left(i) = 0 and Right(i) = 1 then
               Result(i) := BINARY_NUMBER(1);
               Borrow := Borrow + 1;
            elsif Left(i) = 1 and Right(i) = 0 then
               Result(i) := BINARY_NUMBER(1);
            else

               Result(i) := BINARY_NUMBER(0);

            end if;

         elsif Borrow > 0 then

            if Left(i) = 1 and Right(i) = 1 then
               Result(i) := BINARY_NUMBER(1);

            elsif Left(i) = 0 and Right(i) = 0 then
               Result (i) := BINARY_NUMBER(1);

            elsif Left(i) = 1 and Right(i) = 0 then

               Result(i) := BINARY_NUMBER(0);
               Borrow := Borrow - 1;

            else
               Result(i) := BINARY_NUMBER(0);

            end if;
         end if;
      end loop;

      return Result;
   end "-";


   function "-" (Left_Int : in Integer; Right : in BINARY_ARRAY) return BINARY_ARRAY is
      Left: BINARY_ARRAY := Int_To_Bin(Left_Int);
   begin
      return Left - Right;
   end "-";

end Assgn;
