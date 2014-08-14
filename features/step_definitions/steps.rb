Given(/^the program has finished$/) do
  `make clean 2>/dev/null`

  @cucumber = `make 2>/dev/null`
end

Then(/^the output is correct for each test$/) do
  lines = @cucumber.split("\n")

  expect(lines.length).to eq(8)

  expect(lines[0 .. 1].join("\n")).to eq('clang -Wall -Wextra -Wmost -Weverything -framework Foundation -lobjc -o bin/example example.m ObjCheck.m
bin/example')

  expect(lines[2]).to eq('*** Failed!')
  expect(lines[3 .. 5].join("\n")).to match(/^\(\n(\s){4}(\"\-)?[0-9]+(\")?\n\)/m)
  expect(lines[6]).to eq('+++ OK, passed 100 tests.')
  expect(lines[7]).to eq('+++ OK, passed 100 tests.')
end
