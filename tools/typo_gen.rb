File.open(ARGV[0]) do |f|
	puts "<svg xmlns=\"http://www.w3.org/2000/svg\" xml:lang=\"en\">"
	puts "<style type=\"text/css\">
    text {
    	font-size: 16px;
        font-family: Helvetica;
    }
	text[role=\"title\"] {
        font-size: 64px;
        font-weight: bold;
        letter-spacing: -3px;
    }
	</style>"
	offset = 0
	while (line = f.gets)
		parts = line.strip.split("\t")
		# puts parts[0]
		if (parts[0].length < 30)
			puts "<text x=\"100\" y=\"#{offset*100}\" role=\"title\" text-anchor=\"end\">#{parts[0]}</text>"
			puts "<text x=\"104\" y=\"#{offset*100 + 32}\" text-anchor=\"end\">#{parts[1]}</text>"
			# puts "<text x=\"100\" y=\"#{offset*100}\" role=\"title\" text-anchor=\"start\">#{parts[0]}</text>"
			# puts "<text x=\"104\" y=\"#{offset*100 + 32}\" text-anchor=\"start\">#{parts[1]}</text>"
			offset = offset + 1
		end
	end
	puts "</svg>"
end