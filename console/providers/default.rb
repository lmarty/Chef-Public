def whyrun_supported?
  true
end

action :run do
  if @new_resource.creates && ::File.exist?(@new_resource.creates)
    Chef::Log.info "#{ @new_resource } already exists - nothing to do."
  else
    converge_by("Run resource #{ @new_resource }") do
      chef_gem  'greenletters'
      require   'greenletters'
      console_run!
      Chef::Log.info "#{ @new_resource } ran."
    end
  end
  new_resource.updated_by_last_action(true)
end

def console_run!
  command = "sudo -u #{@new_resource.user} " if @new_resource.user
  command += @new_resource.name

  args = Hash.new
  args[:timeout]   = @new_resource.timeout
  args[:cwd]       = @new_resource.cwd         if @new_resource.cwd
  args[:env]       = @new_resource.environment if @new_resource.environment
  args[:transcript] = Chef::Log if Chef::Config[:log_level] == :debug
  process = ::Greenletters::Process.new(command, args)
  @new_resource.interrupts.each do |regex, response|
    process.on(:output, regex) do
      process << response
    end
  end if @new_resource.interrupts
  process.start!
  @new_resource.answers.each do |regex, response|
    process.wait_for(:output, regex) do
      process << response
    end
  end if @new_resource.answers
  process.wait_for(:exit)
end
