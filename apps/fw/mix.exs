defmodule Fw.Mixfile do
  use Mix.Project

  @target System.get_env("NERVES_TARGET") || "rpi3"

  def project do
    [app: :fw,
     version: "0.0.1",
     target: @target,
     archives: [nerves_bootstrap: "~> 0.1.4"],
     deps_path: "../../deps/#{@target}",
     build_path: "../../_build/#{@target}",
     lockfile: "../../mix.lock",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases,
     deps: deps ++ system(@target)]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Fw, []},
      applications: [
        :logger,
        :nerves_neopixel,
        :nerves_networking,
        :nerves_interim_wifi,
        :nerves_firmware_http,
        :nerves_lora_gateway,
        :nerves_uart,
        :ui,
        :nerves_ntp
      ]
    ]
  end

  def deps do
    [
      {:nerves, "~> 0.3.0"},
      {:nerves_neopixel, "~> 0.3.0"},
      {:nerves_networking, github: "nerves-project/nerves_networking"},
      {:nerves_interim_wifi, github: "nerves-project/nerves_interim_wifi"},
      {:nerves_firmware_http, github: "nerves-project/nerves_firmware_http"},
      {:nerves_lora_gateway, github: "developerworks/nerves_lora_gateway"},
      {:nerves_uart, "~> 0.1.1"},
      {:ui, in_umbrella: true},
      {:nerves_ntp, "~> 0.1.1"},
    ]
  end

  def system(target) do
    [
      {:"nerves_system_#{target}", github: "nerves-project/nerves_system_rpi3"}
    ]
  end

  def aliases do
    ["deps.precompile": ["nerves.precompile", "deps.precompile"],
     "deps.loadpaths":  ["deps.loadpaths", "nerves.loadpaths"]]
  end

end
