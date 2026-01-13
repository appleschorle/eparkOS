{...}: {
  xdg.desktopEntries.chatgpt = {
    name = "ChatGPT";
    exec = "firefox --new-window https://chat.openai.com --name chatgpt --class chatgpt";
    icon = "firefox";
    categories = ["Network" "Utility"];
  };
}
