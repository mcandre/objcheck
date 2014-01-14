Given(/^the program has finished$/) do
  `make clean 2>/dev/null`

  @cucumber = `make 2>/dev/null`
end

Then(/^the output is correct for each test$/) do
  lines = @cucumber.split("\n")

  lines.length.should == 8

  lines[0 .. 1].join("\n").should == 'clang -Wall -Wextra -Wmost -Weverything -framework Foundation -lobjc -o example example.m ObjCheck.m
./example'

  lines[2].should == '*** Failed!'
  lines[3 .. 5].join("\n").should =~ /^\(\n(\s){4}(\"\-)?[0-9]+(\")?\n\)/m
  lines[6].should == '+++ OK, passed 100 tests.'
  lines[7].should == '+++ OK, passed 100 tests.'
end
