require 'faker'

# => User does not seed properly, Argument Error,
# user has no Name/Company ID
50.times do
  u = User.create!(
    # Faker::Name.name,
    # company_id: rand(1..10)
    email: Faker::Internet.email,
    password: Faker::Cat.registry

    )
end

tools = %w(rails php asp python facebook adwords git css html javascript xml)

tools.each do |tool|
  t = Tool.create!(
    name: tool
    )
end


10.times do
  c = Company.create!(
    name: Faker::SiliconValley.company
    )
end

50.times do
  ct = CompanyTool.create!(
    tool_id: rand(1..11),
    company_id: rand(1..10)
    )
end



100.times do
  ct = UserTool.create!(
    tool_id: rand(1..11),
    user_id: rand(1..50)
    )
end
