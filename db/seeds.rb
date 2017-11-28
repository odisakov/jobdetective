require 'faker'

techs = %w(rails php asp python facebook adowrds git css html javascript)

techs.each do |technology|
  t = Tech.create!(
    name: technology
    )
end



10.times do
  c = Company.create!(
    name: Faker::SiliconValley.company,
    )
end


# 30.times do
#   u = User.create!(
#     name: Faker::Name.name,
#     company_id: rand(1..10),
#     )
# end

30.times do
  ct = CompanyTech.create!(
    company_id: rand(1..10),
    tech_id: rand(1..10)
    )
end
