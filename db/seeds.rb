require 'csv'
require 'faker'
require 'open-uri'
require 'nokogiri'


# Create Companies from Crunchbase CSV
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
  c.crunchbase_url = row['crunchbase_url'].gsub(/\?\S*/, "")
  c.save
  p "Created Company #{c.name}"

  # Scraping Techs for Company - STACKSHARE
  stackshare = "https://stackshare.io/"
  company_name = c.name.downcase.gsub(" se", "").gsub(" gmbh", "").gsub(" ag", "").gsub(" ug", "").gsub(" ","-")
  stack_url = "#{stackshare}#{company_name}/#{company_name}"

  p "Fetching #{stack_url}"
  stack_tools = []
  stack_tools_hash = {}
  begin
    doc = Nokogiri::HTML(open(stack_url), nil, 'utf-8')
  rescue
    puts "404 rescued"
    c.destroy!
    puts "#{c.name} deleted"
  end
  unless doc == nil
    array_of_tools = []
    doc.search('#stack-item-services-tile').each do |section|
      section.css('#stp-services').each do |element|
        img = element.css('img').first.attributes["src"].value
        p img
        title = element.css('a.stack-service-name-under').first.text
        p title
        tool = {
          name: title,
          picture: img
        }
        array_of_tools << tool
      end

      array_of_tools.uniq.each do |tool|
        current_tool = Tool.find_by_name(tool[:name])
        if current_tool
          ct = CompanyTool.create!(
            company: c,
            tool: current_tool,
            )
        else
          new_tool = Tool.new(
            name: tool[:name],
            image_url: tool[:picture]
            )
          new_tool.save
          ct = CompanyTool.create!(
            company: c,
            tool: new_tool,
            )
        end
      end
    end
  end
end


# Create Employees - Faker
role = %w(management engineering sales)

50.times do
  u = User.create!(
    company: Company.order("RANDOM()").first,
    email: Faker::Internet.email,
    password: Faker::Crypto.md5,
    linkedin_pic_url: "http://res.cloudinary.com/dbp2j1emu/image/upload/q_auto:eco/v1512407043/default_user_dizcx8.jpg",
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    employment_role: role.sample
    )
end
