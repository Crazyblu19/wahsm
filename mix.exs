defmodule Wahsm.MixProject do
  use Mix.Project

  def project do
    [
      app: :wahsm,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases(),
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Wahsm.Application, []},
    ]
  end

  defp aliases do
    [
      wasm: &wasm/1,
    ]
  end

  def wasm(_) do
    Mix.shell().cmd("zig build-lib wasm/main.zig -target wasm32-freestanding -dynamic -rdynamic -O ReleaseSmall")
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
	 	{:wasmex, "~> 0.8.1"}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
