def calcARI(fileName)
    file = File.open(fileName)
    x = file.read.split('')

    characters = 0
    words = 0
    sentences = 0
    spaces = 0


    for char in x
        if char == " "
            words = words + 1
        elsif char == "."
            sentences = sentences + 1
        end
        characters += 1
    end

    characters = characters-words
    words += 1

    ari = (4.71*(characters/words)+0.5*(words/sentences)-21.43)

    puts ""
    puts "Total # of characters: #{characters}"
    puts ""
    puts "Total # of words: #{words}"
    puts ""
    puts "Total # of sentences: #{sentences}"
    puts ""
    puts "Automated Readability Index: #{ari.round(1)}"
    puts ""

    case ari.to_i
    when 1
        puts "Grade level: 5-6 (Kindergarten)"
    when 2
        puts "Grade level: 6-7 (First/Second Grade)"
    when 3
        puts "Grade level: 7-9 (Third Grade)"
    when 4
        puts "Grade level: 9-10 (Fourth Grade)"
    when 5
        puts "Grade level: 10-11 (Fifth Grade)"
    when 6
        puts "Grade level: 11-12 (Sixth Grade)"
    when 7
        puts "Grade level: 12-13 (Seventh Grade)"
    when 8
        puts "Grade level: 13-14 (Eighth Grade)"
    when 9
        puts "Grade level: 14-15 (Ninth Grade)"
    when 10
        puts "Grade level: 15-16 (Tenth Grade)"
    when 11
        puts "Grade level: 16-17 (Eleventh Grade)"
    when 12
        puts "Grade level: 17-18 (Twelfth grade)"
    when 13
        puts "Grade level: 18-24 (College student)"
    when 14
        puts "Grade level: 24+ (Professor)"
    end

    puts ""
end

calcARI("paragraph.txt")