######################
# Stage: base Builder
FROM ruby:2.6-alpine as base
RUN apk add --update --no-cache \
    build-base \
    postgresql-dev \
    git \
    nodejs-current \
    yarn \
    bash \
    tzdata \
    tree
ARG app_name=rails5
# Add user "$app_name"
RUN addgroup -g 1000 -S $app_name \
 && adduser -h /$app_name -u 1000 -S $app_name -G $app_name

USER $app_name

WORKDIR /$app_name
RUN gem install bundler:2.2.16
ADD --chown=$app_name:$app_name Gemfile .
ADD --chown=$app_name:$app_name Gemfile.lock .
# ADD --chown=$app_name:$app_name .bundle .bundle 
RUN mkdir tmp
RUN mkdir public
RUN export PATH=$PATH:/$app_name/bin
RUN printf "export PATH=$PATH:/$app_name/bin\nexport HISTFILESIZE=100000\nexport HISTSIZE=10000000\nexport PS1='\u \H \w '\n " >> /$app_name/.bashrc
EXPOSE 3000
RUN bundle config set --local path 'vendor/bundle'
USER $app_name

FROM base AS development
ARG app_name=rails5
#RUN bundle install
#RUN bundle exec rake assets:precompile
USER root
RUN apk add --update --no-cache \
    zsh \
    neovim \
    keychain \
    postgresql-client \
    openssh-client \
    git \
    neovim \
    tree \
    curl

USER $app_name
RUN bundle install --with development test
RUN mkdir -p .config/nvim
ADD --chown=$app_name:$app_name ./docker_dev/.bashrc .bashrc
ADD --chown=$app_name:$app_name ./docker_dev/init.vim .config/nvim/init.vim

RUN sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
RUN sh -c "nvim +PlugInstall +qall "
ADD --chown=$app_name:$app_name .bundle .bundle
ADD --chown=$app_name:$app_name Rakefile .
ADD --chown=$app_name:$app_name app app 
ADD --chown=$app_name:$app_name config config
ADD --chown=$app_name:$app_name db db
ADD --chown=$app_name:$app_name bin bin
ADD --chown=$app_name:$app_name lib lib
ADD --chown=$app_name:$app_name config.ru .
ADD --chown=$app_name:$app_name docker_extras/.zshrc .
ADD --chown=$app_name:$app_name docker_extras/.ssh .ssh
ADD --chown=$app_name:$app_name docker_extras/.oh-my-zsh .oh-my-zsh
EXPOSE 3001
