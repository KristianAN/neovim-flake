{ pkgs, metals-pkg}:
{
 nodeDeps = with pkgs; [
 ];

 shellDeps = with pkgs; [
   ripgrep
   haskell-language-server
   coursier
   jdt-language-server
   metals-pkg
 ];
}
