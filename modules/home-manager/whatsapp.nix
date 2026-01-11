{...}: {
  xdg.desktopEntries.whatsapp = {
    name = "WhatsApp";
    exec = "firefox --new-window https://web.whatsapp.com --name whatsapp --class whatsapp";
    icon = "whatsapp";
    categories = ["Network" "Chat"];
  };
}
