# Add vendor path for Kingadmin theme
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
Rails.application.config.assets.precompile << /\.(?:svg|eot|woff|ttf)$/

# Add Yarn mode_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile Additional Assets
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w(admin.js admin.css )
Rails.application.config.assets.precompile += %w(kingadmin-logo-white.png kingadmin-logo.png)
Rails.application.config.assets.precompile += %w(ico/.*\.png)
Rails.application.config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif *.js)
