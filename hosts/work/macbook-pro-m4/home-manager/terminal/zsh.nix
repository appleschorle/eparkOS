{flakeRootPath, ...}: {
  imports = [
    "${flakeRootPath}/modules/home-manager/terminal/zsh.nix"
  ];

  epark.terminal.zsh = {
    enable = true;

    sessionVariables = {
      AWS_CONFIG_FILE = "$HOME/.config/aws/config";
    };

    zshrc = ''
      # Nix - source here to survive macOS updates wiping /etc/zshrc
      if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
        . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
      fi
    '';

    shellAliases = {
      sc-list = ''aws servicecatalog search-provisioned-products --region eu-west-1 --query "ProvisionedProducts[*].{Name:Name,Status:Status,CreatedTime:CreatedTime}" --output table'';
      ff-mk = ''aws servicecatalog provision-product --region eu-west-1 --product-name gov-team-account-fire-fighter-role --provisioning-artifact-id $(aws servicecatalog describe-product --name gov-team-account-fire-fighter-role --region eu-west-1 --query "ProvisioningArtifacts[0].Id" --output text) --provisioned-product-name gov-team-account-fire-fighter-role-$(date +"%s")'';
      ff-rm = ''for id in $(aws servicecatalog search-provisioned-products --region eu-west-1 --query "ProvisionedProducts[*].{Name:Name,Id:Id,Status:Status,CreatedTime:CreatedTime}" --output json | jq -rc '.[] | select(.Name | contains ("gov-team-account-fire-fighter-role-")) | .Id'); do aws servicecatalog terminate-provisioned-product --region eu-west-1 --provisioned-product-id ''$id; done'';
      seed-mk = ''aws servicecatalog provision-product --region eu-west-1 --product-name gov-team-account-federated-deploy-role --provisioning-artifact-id $(aws servicecatalog describe-product --name gov-team-account-federated-deploy-role --region eu-west-1 --query "ProvisioningArtifacts[0].Id" --output text) --provisioned-product-name gov-team-account-federated-deploy-role-seed-$(date +"%s") --provisioning-parameters Key=AuthorizedGitlabPath,Value="csdt-gitlab/gitlab-ha/gitlab-seed:ref_type:*:ref:*" Key=OidcProviderName,Value=gitlab.scania.com Key=Suffix,Value=seed'';
      seed-rm = ''for id in $(aws servicecatalog search-provisioned-products --region eu-west-1 --query "ProvisionedProducts[*].{Name:Name,Id:Id,Status:Status,CreatedTime:CreatedTime}" --output json | jq -rc '.[] | select(.Name | contains ("gov-team-account-federated-deploy-role-seed-")) | .Id'); do aws servicecatalog terminate-provisioned-product --region eu-west-1 --provisioned-product-id ''$id; done'';
    };
  };
}
