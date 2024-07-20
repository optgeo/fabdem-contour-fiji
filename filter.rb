require 'json'
LAYER = 'contour'

def dump(f, minzoom, maxzoom)
  f['tippecanoe'] = {
    'layer' => LAYER,
    'minzoom' => minzoom,
    'maxzoom' => maxzoom
  }
  print "#{JSON.dump(f)}\n"
end

while gets
  f = JSON.parse($_)
  h = f['properties']['h']
  if h % 400 == 0
    dump(f, 9, 14)
  elsif h % 200 === 0
    dump(f, 10, 14) 
  elsif h % 100 == 0
    dump(f, 11, 14)
  elsif h % 50 == 0
    dump(f, 12, 12)
    dump(f, 14, 14)
  elsif h % 20 == 0
    dump(f, 13, 14)
  else
    dump(f, 14, 14)
  end
end

