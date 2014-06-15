function output = keep_caps(input)

    input = cellstr(input);
    input = input{1};
    cap_id = find((input >= 65 & input <= 90) | (input >= 97 & input <= 122) | (input >= 48 & input <= 57));
    output = input(cap_id);

end