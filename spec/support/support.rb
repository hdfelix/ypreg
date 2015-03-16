RSpec::Matchers.define :have_constant do |const|
  match do |owner|
    (owner.is_a?(Class) ? owner : owner.class).const_defined?(const)
  end
end
