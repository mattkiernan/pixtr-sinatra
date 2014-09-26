fruit_colors = {
  apple: "red",
  pear: "green",
  banana: "yellow"
}

def fruits(hash)
  hash.each {|(fruit, color)| puts "All #{fruit}s are #{color}"}
end

fruits(fruit_colors)
