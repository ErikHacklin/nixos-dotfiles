{ pkgs, ... }:
{
  programs.waybar = {
    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font";
        font-size: 10pt;
        font-weight: bold;
        border-radius: 6px;
        transition-property: background-color;
        transition-duration: 0.3s;
      }
      @keyframes blink_red {
        to {
          background-color: @base08;
          color: rgb(26, 24, 38);
        }
      }
      .warning, .critical, .urgent {
        animation-name: blink_red;
        animation-duration: 1s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }
      window#waybar {
        background-color: transparent;
      }
      window > box {
        margin-left: 5px;
        margin-right: 5px;
        margin-top: 5px;
        background-color: @base00;
        padding: 3px;
        padding-left:8px;
        border: 2px solid @base0D;
      }
      #workspaces {
        padding-left: 0px;
        padding-right: 4px;
      }
      #workspaces button {
        padding-top: 5px;
        padding-bottom: 5px;
        padding-left: 6px;
        padding-right: 6px;
      }
      #workspaces button.active {
        background-color: @base0D;
        color: @base00;
      }
      #workspaces button.urgent {
        color: @base00;
      }
      #workspaces button:hover {
        background-color: @base0D;
        color: @base00;
      }
      tooltip {
        background: rgb(48, 45, 65);
      }
      tooltip label {
        color: @base05;
      }
      #window {
        margin-left: 10px;
      }
      #clock, #memory, #temperature, #cpu, #backlight, #pulseaudio, #network, #battery {
        padding-left: 10px;
        padding-right: 10px;
      }
      #clock, #temperature, #battery {
        color: @base05;
      }
      #pulseaudio {
        color: @base0E;
      }
      #backlight {
        color: @base0A;
      }
      #cpu {
        color: @base0C;
      }
      #disk {
        color: @base0F;
      }
      #memory {
        color: @base09;
      }
      #network {
        color: @base0B;
      }
      #network.disconnected {
        color: @base08;
      }
      #tray {
        padding-right: 8px;
        padding-left: 10px;
      }
    '';
  };
}