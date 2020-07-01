
def type(type)
  "file"
  {
    "file": "-",
    "directory": "d",
    "link": "l"
  }[:"file"]
end

p type(:"file")
