platform :ios do

    def public_release(workspace, framework, repo, podspec)
        # xcversion(version: "11.7")

        cocoapods_archive = archive_framework_for_cocoapods(workspace, framework)
        cathage_archive = archive_framework_for_carthage(framework)
    
        version = get_version_number(
        target: framework)

        name = "Release " + version
        token = File.read("github.token")

        upload_to_github(
            token,
            version,
            name,
            "No changelog provided",
            repo,
            [cocoapods_archive, cathage_archive]
        )

        version_bump_podspec(path: podspec, version_number: version)
        pod_push

        message = "Update latest " + framework + " build"
        commit_and_push(message)
    end
    
    def commit_and_push(message) 
        git_add
        git_commit(path: "*", message: message)
        push_to_git_remote(
            local_branch: "master",
            remote_branch: "master")
    end

    def build_xcframework(workspace, framework) 
        output_dir = 'Build/XCFrameworks'

        create_xcframework(
            workspace: workspace,
            scheme: framework,
            destinations: ['iOS'],
            xcframework_output_directory: output_dir,
            include_dSYMs: true, 
            include_BCSymbolMaps: true
        )

        return output_dir + "/" + framework + ".xcframework"
    end  

    def archive_framework_for_cocoapods(workspace, framework) 
        output_zip = framework + "_Cocoapods.framework.zip"

        framework_path = build_xcframework(workspace, framework)
        archive(framework_path, output_zip)

        return output_zip
    end  

    def archive_framework_for_carthage(framework)
        carthage_build()

        output_zip = framework + ".framework.zip"

        carthage(
            command: "archive",
            frameworks: [framework],
            output: output_zip)

        return output_zip  
    end

    def carthage_build() 
        sh("cd .. && ./carthage-build.sh build --platform iOS --no-skip-current")
    end

    def upload_to_github(token, tag_name, name, description, repository_name, assets)
        set_github_release(
            tag_name: tag_name,
            name: name,
            description: description,
            repository_name: repository_name,
            api_token: token,
            upload_assets: assets)

        delete_files(assets)
    end

    def archive(src, dst)
        src = "../" + src
        dst = "../" + dst
        sh("ditto", "-c", "-k", "--sequesterRsrc", "--keepParent", src, dst)
    end

    def delete_files(files) 
        command = "cd .. && rm " + files.join(' ')
        sh(command)
    end 
end
