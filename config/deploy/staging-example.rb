set :stage, :staging
set :public_symlink_location, -> {"/home/#{fetch(:username)}/otherSubfolderLocationForStagingIfApplicable/public_html"}

# Simple Role Syntax
# ==================
#role :app, %w{deploy@example.com}
#role :web, %w{deploy@example.com}
#role :db,  %w{deploy@example.com}

# Extended Server Syntax
# The IP address for staging is often different than production, depending on the web host.
# Other times, you might need to use a subfolder within the same IP address as production.
# ======================
server '123.456.789.012', user: 'validUsernameForSSH', roles: %w{web app db}
# server '123.456.789.012', user: "#{fetch(:username)}", roles: %w{web app db}

# you can set custom ssh options
# it's possible to pass any option but you need to keep in mind that net/ssh understand limited list of options
# you can see them in [net/ssh documentation](http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start)
#
#
# Run these commands before deployment, to get the SSH key setup for password-free deployment.
    # FYI - This assumes that the public key is already on the remote server.
    # eval "$(ssh-agent -s)"
    # ssh-add /mnt/c/Users/Username/.ssh/private_openssh
 set :ssh_options, {
   keys: %w(~/.ssh/subfolderLocation/id_rsa),
   forward_agent: true,
   auth_methods: %w(publickey),
   port: 22 # Replace number with your custom port. Default 22.
 }

fetch(:default_env).merge!(wp_env: :staging)