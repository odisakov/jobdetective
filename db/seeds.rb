require 'csv'
require 'faker'
require 'open-uri'
require 'nokogiri'

builtwith = "https://builtwith.com/"

# file = "/Users/daniel/Downloads/built.html"
# doc = Nokogiri::HTML(File.open(file), nil, 'utf-8')

# doc.search('.techItem > h3').each_with_index do |element, index|
#   puts "#{index + 1}. #{element.text.strip}"
# end

csv_options = { col_sep: ',', quote_char: '"', headers: :first_row }
csv_text = File.read(Rails.root.join('lib', 'seeds', 'crunch.csv'))

csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  #Create Company
  c = Company.new
  c.name = row['name']
  c.city = row['location_city']
  c.country = row['location_country_code']
  c.short_description = row['short_description']
  c.logo_url = row['profile_image_url']
  c.homepage_url = row['homepage_url']
  c.homepage_domain = row['homepage_domain']
  c.save

  # p "Created Company #{c.name}"


  # Scraping Techs for Company
  bw_url = "#{builtwith}#{c.homepage_domain}"
  p "Start scraping #{bw_url}"
  doc = Nokogiri::HTML(open(bw_url), nil, 'utf-8')
  bw_tools = []
  doc.search('.techItem > h3').each do |element|
    bw_tools << element.text.strip
  end
  # p "Scraping complete"

  # for each tool check if exits
  bw_tools.each do |tool|
    exist = Tool.find_by_name(tool)
    if exist
      p "#{tool} found in DB."
      ct = CompanyTool.create!(
        company: c,
        tool: exist
        )
      ct.save
      p "CompanyTool created"
    else
      p "#{tool} NOT found. Creating.."
      new_tool = Tool.new
      new_tool.name = tool
      new_tool.save
      ct = CompanyTool.create!(
        company: c,
        tool: new_tool
        )
      ct.save
      p "CompanyTool created"

    end
  end
end



# tools = %w(rails php asp python facebook adwords git css html javascript)
# role = %w(ceo engineering sales)

# tools.each do |technology|
#   t = Tool.create!(
#     name: technology
#     )
# end



# 100.times do
#   u = User.create!(
#     # name: Faker::Name.name,
#     company: Company.order("RANDOM()").first,
#     email: Faker::Internet.email,
#     password: Faker::Crypto.md5,
#     linkedin_pic_url: "https://dizivizi.com/mbb/imgs/site/default_user.png",
#     first_name: Faker::Name.first_name,
#     last_name: Faker::Name.last_name,
#     employment_role: role.sample
#     )
# end

# 10.times do
#   ct = CompanyTool.create!(
#     company_id: rand(1..10),
#     tool_id: rand(1..10)
#     )
# end


# 10.times do
#   ct = UserTool.create!(
#     user_id: rand(1..10),
#     tool_id: rand(1..10)
#     )
# end
