cask "intellij-idea@2023.1" do
  version "2023.1,231.8109.175"

  name "JetBrains IntelliJ IDEA #{version.before_comma}"
  desc "Java IDE"
  homepage "https://www.jetbrains.com/idea/"

  app "IntelliJ IDEA.app", target: "IntelliJ IDEA #{version.before_comma}.app"

  if Hardware::CPU.intel?
      url "https://download.jetbrains.com/idea/ideaIU-2023.1.dmg"
      sha256 "1e8498336a5c4d90518f47d687a167adbe0e634d1f7d10530164c84542b91677"
  else
      url "https://download.jetbrains.com/idea/ideaIU-2023.1-aarch64.dmg"
      sha256 "6e2ca530fe082f79724fb89849e06fa91b8c17089430f9633a7e9a813204151f"
  end

  uninstall_postflight do
    ENV["PATH"].split(File::PATH_SEPARATOR).map { |path| File.join(path, "idea") }.each do |path|
      if File.exist?(path) &&
        File.readlines(path).grep(/# see com.intellij.idea.SocketLock for the server side of this interface/).any?
        File.delete(path)
      end
    end
  end

  zap trash: [
    "~/Library/Application Support/JetBrains/IntelliJIdea#{version.major_minor}",
    "~/Library/Caches/JetBrains/IntelliJIdea#{version.major_minor}",
    "~/Library/Logs/JetBrains/IntelliJIdea#{version.major_minor}",
    "~/Library/Preferences/com.jetbrains.intellij.plist",
    "~/Library/Preferences/IntelliJIdea#{version.major_minor}",
    "~/Library/Preferences/jetbrains.idea.*.plist",
    "~/Library/Saved Application State/com.jetbrains.intellij.savedState",
  ]
end
