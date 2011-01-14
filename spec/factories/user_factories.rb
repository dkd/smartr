Factory.define :user do |u|
    u.login 'John3000'
    u.email 'John@gmailtest.com'
    u.password 'tester2000'
    u.password_confirmation 'tester2000'
    u.is_admin false
end