require 'open-uri'
require 'nokogiri'
require 'csv'

url = ARGV[0]
filename = ARGV[1]


html = open(url)
page = Nokogiri::HTML(html)
pageProduct = Nokogiri::HTML(open('https://www.petsonic.com/hobbit-alf-galletas-granja-para-perros.html'))

# productPage # пробовал получить все через post запрос - не вышло

nameproduct = []
pageProduct.xpath('//h1[@itemprop="name"]').each do |name|
  nameproduct.push(name.content)
end

imageproduct = []
pageProduct.xpath('//img[@id="bigpic"]/@src').each do |image|
  imageproduct.push(image.content)
end

weightProduct = []
pageProduct.xpath('//span[@class="radio_label"]').each do |weight|
  weightProduct.push(weight.content)
end

priceProduct = []
pageProduct.xpath('//span[@class="price_comb"]').each do |price|
  priceProduct.push(price.content)
end


# write to csv
CSV.open("#{filename}"+".csv","w") do |csv|
  page.xpath('//a[@class="product-name"]/@title').each do |name|
    csv << ["name - " + "#{name.content}"]
  end

  page.xpath('//img[@itemprop="image"]/@src').each do |image|
    csv << ["image - " + "#{image.content}"]
  end

  page.xpath('//span[@itemprop="price"]/@content').each do |price|
    csv << ["price - " + "#{price.content}"]
  end

  csv << ["-------------------------------------------------------"]
  csv << ["#{nameproduct[0]} - " + "#{weightProduct[0]}"]
  csv << ["#{priceProduct[0]}"]
  csv << ["#{imageproduct[0]}"]
  csv << ["-------------------------------------------------------"]
  csv << ["#{nameproduct[0]} - " + "#{weightProduct[1]}"]
  csv << ["#{priceProduct[1]}"]
  csv << ["#{imageproduct[0]}"]
  csv << ["-------------------------------------------------------"]
  csv << ["#{nameproduct[0]} - " + "#{weightProduct[2]}"]
  csv << ["#{priceProduct[2]}"]
  csv << ["#{imageproduct[0]}"]
end






