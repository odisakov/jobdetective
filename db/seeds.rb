require 'faker'

tools = %w(rails php asp python facebook adowrds git css html javascript)
role = %w(ceo engineering sales)

tools.each do |technology|
  t = Tool.create!(
    name: technology
    )
end



100.times do
  c = Company.create!(
    name: Faker::SiliconValley.company,
    logo_url: "http://khppu.com/assets/default_user_company_logo-3058b28cca9e293f85b78add4842bc64.png",
    city: "Berlin",
    country: "Germany",
    short_description: Faker::SiliconValley.motto
    )
  # p "Created company #{c}"
end


100.times do
  u = User.create!(
    # name: Faker::Name.name,
    company: Company.order("RANDOM()").first,
    email: Faker::Internet.email,
    password: Faker::Crypto.md5,
    linkedin_pic_url: "https://dizivizi.com/mbb/imgs/site/default_user.png",
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    employment_role: role.sample
    )
end

300.times do
  ct = CompanyTool.create!(
    company_id: rand(1..10),
    tool_id: rand(1..10)
    )
end


300.times do
  ct = UserTool.create!(
    user_id: rand(1..10),
    tool_id: rand(1..10)
    )
end
