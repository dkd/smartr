# More Info here: http://www.ksylvest.com/posts/2012-03-09/faster-testing-in-rails-with-guard-for-zeus-rspec-and-cucumber
guard "bundler" do
  watch("Gemfile")
end

#guard "cucumber", command_prefix: "zeus", bundler: false do
#  watch(%r{^features/.+\.feature$})
#  watch(%r{^features/support/.+$}) { "features" }
#  watch(%r{^features/step.+/.+$})  { "features" }
#end

guard "rspec", zeus: true, bundler: false do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch("spec/spec_helper.rb")  { "spec" }

  watch(%r{^app/(.+)\.rb$})                           { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^app/(.*)(\.erb|\.slim|\.haml)$})          { |m| "spec/#{m[1]}#{m[2]}_spec.rb" }
  watch(%r{^app/controllers/(.+)_(controller)\.rb$})  { |m| ["spec/routing/#{m[1]}_routing_spec.rb", "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb", "spec/acceptance/#{m[1]}_spec.rb"] }
  watch(%r{^spec/support/(.+)\.rb$})                  { "spec" }
  watch("config/routes.rb")                           { "spec/routing" }
  watch("app/controllers/application_controller.rb")  { "spec/controllers" }

  watch(%r{^app/views/(.+)/.*\.(erb|slim|haml)$})          { |m| "spec/views/#{m[1]}_spec.rb" }
end