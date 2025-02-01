FROM ghcr.io/nixos/nix

ARG UID=1000
ARG GID=1000

WORKDIR /app/build
COPY . ./

# install dependencies
RUN nix-env -iA nixpkgs.busybox nixpkgs.curlMinimal

# https://github.com/hiibolt/nix-flake-docker/blob/653a50163c2d07ccc282985458ca239d163dd75c/Dockerfile#L3-L5
# set up the environment for nix flakes
RUN nix-channel --update
RUN echo "experimental-features = nix-command flakes" >> /etc/nix/nix.conf

# build nix flake
RUN nix build .

WORKDIR /app/run

# setup cronjob
COPY docker/update.cron /etc/cron.d/meta-update
RUN chmod 644 /etc/cron.d/meta-update \
    && mkdir -p /var/spool/cron/crontabs \
    && crontab /etc/cron.d/meta-update

# install entrypoint
COPY docker/entrypoint.sh /usr/local/bin/entrypoint
RUN chmod +x /usr/local/bin/entrypoint

RUN addgroup -g $GID user \
    && adduser --disabled-password --ingroup user --uid $UID user \
    && mkdir -p /home/user/.ssh \
    && ssh-keyscan github.com > /home/user/.ssh/known_hosts \
    && mkdir -p /app \
    && chown -R $UID:$GID /app /home/user/.ssh

ENTRYPOINT ["/usr/local/bin/entrypoint"]
CMD ["update"]
