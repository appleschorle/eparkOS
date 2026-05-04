{
  config,
  lib,
  ...
}: let
  cfg = config.epark.zsh;
in {
  options.epark.zsh.enable = lib.mkEnableOption "Enable zsh";

  config = lib.mkIf cfg.enable {
    # And add pasting to nvim from + when in visual mode
    home.sessionPath = [
      "/opt/homebrew/opt/ruby@3.3/bin"
      "/opt/homebrew/lib/ruby/gems/3.3.0/bin"
      "/opt/homebrew/bin"
      "/opt/homebrew/sbin"
      "$HOME/.local/bin"
      "$HOME/repos/gdk/bin"
      "/Applications/Rancher Desktop.app/Contents/Resources/resources/darwin/bin"
    ];

    programs.zsh = {
      enable = true;
      envExtra = ''
        # Nix - source here to survive macOS updates wiping /etc/zshrc
        if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
          . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
        fi
      '';
      enableCompletion = true;
      enableVteIntegration = true;
      autocd = true;
      autosuggestion = {
        enable = true;
      };
      defaultKeymap = "viins";
      history = {
        append = true;
        expireDuplicatesFirst = true;
        extended = true;
        findNoDups = true;
      };
      initContent = ''
        bindkey '^F' autosuggest-accept
        autoload -Uz edit-command-line
        zle -N edit-command-line
        bindkey '^E' edit-command-line
      '';
      shellAliases = {
        ll = "ls -lh";
        sc-list = ''aws servicecatalog search-provisioned-products --region eu-west-1 --query "ProvisionedProducts[*].{Name:Name,Status:Status,CreatedTime:CreatedTime}" --output table'';
        ff-mk = ''aws servicecatalog provision-product --region eu-west-1 --product-name gov-team-account-fire-fighter-role --provisioning-artifact-id $(aws servicecatalog describe-product --name gov-team-account-fire-fighter-role --region eu-west-1 --query "ProvisioningArtifacts[0].Id" --output text) --provisioned-product-name gov-team-account-fire-fighter-role-$(date +"%s")'';
        ff-rm = ''for id in $(aws servicecatalog search-provisioned-products --region eu-west-1 --query "ProvisionedProducts[*].{Name:Name,Id:Id,Status:Status,CreatedTime:CreatedTime}" --output json | jq -rc '.[] | select(.Name | contains ("gov-team-account-fire-fighter-role-")) | .Id'); do aws servicecatalog terminate-provisioned-product --region eu-west-1 --provisioned-product-id ''$id; done'';
        seed-mk = ''aws servicecatalog provision-product --region eu-west-1 --product-name gov-team-account-federated-deploy-role --provisioning-artifact-id $(aws servicecatalog describe-product --name gov-team-account-federated-deploy-role --region eu-west-1 --query "ProvisioningArtifacts[0].Id" --output text) --provisioned-product-name gov-team-account-federated-deploy-role-seed-$(date +"%s") --provisioning-parameters Key=AuthorizedGitlabPath,Value="csdt-gitlab/gitlab-ha/gitlab-seed:ref_type:*:ref:*" Key=OidcProviderName,Value=gitlab.scania.com Key=Suffix,Value=seed'';
        seed-rm = ''for id in $(aws servicecatalog search-provisioned-products --region eu-west-1 --query "ProvisionedProducts[*].{Name:Name,Id:Id,Status:Status,CreatedTime:CreatedTime}" --output json | jq -rc '.[] | select(.Name | contains ("gov-team-account-federated-deploy-role-seed-")) | .Id'); do aws servicecatalog terminate-provisioned-product --region eu-west-1 --provisioned-product-id ''$id; done'';
      };
      shellGlobalAliases = {
        G = "| grep";
      };
      siteFunctions = {
        mkcd = ''
          mkdir --parents "$1" && cd "$1"
        '';
      };
      syntaxHighlighting = {
        enable = true;
        highlighters = [
          "main"
          "brackets"
          "root"
          "cursor"
        ];
      };
      sessionVariables = {
        EDITOR = "vi";

        AWS_CONFIG_FILE = "$HOME/.config/aws/config";

        XDG_CONFIG_HOME = "$HOME/.config";
        XDG_CACHE_HOME = "$HOME/.cache";
        XDG_DATA_HOME = "$HOME/.local/share";
        XDG_STATE_HOME = "$HOME/.local/share";
      };
    };
  };
}
