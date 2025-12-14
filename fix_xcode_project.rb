require 'xcodeproj'

project_path = 'ios/Runner.xcodeproj'
file_name = 'GoogleService-Info.plist'
group_name = 'Runner'

project = Xcodeproj::Project.open(project_path)
target = project.targets.find { |t| t.name == 'Runner' }
group = project.main_group.find_subpath(group_name, true)

# Create reference (it handles existing checks internally usually, or we verify)
# The path is relative to the group, which usually maps to the physical folder 'Runner'
file_ref = group.find_file_by_path(file_name) || group.new_reference(file_name)

# Add to resources build phase
resources_phase = target.resources_build_phase
unless resources_phase.files_references.include?(file_ref)
  resources_phase.add_file_reference(file_ref)
  project.save
  puts "Successfully added #{file_name} to Xcode project."
else
  puts "#{file_name} was already in that build phase."
end
