#compdef cargo-shuttle

autoload -U is-at-least

_cargo-shuttle() {
    typeset -A opt_args
    typeset -a _arguments_options
    local ret=1

    if is-at-least 5.2; then
        _arguments_options=(-s -S -C)
    else
        _arguments_options=(-s -C)
    fi

    local context curcontext="$curcontext" state line
    _arguments "${_arguments_options[@]}" \
'-h[Print help]' \
'--help[Print help]' \
":: :_cargo-shuttle_commands" \
"*::: :->cargo-shuttle" \
&& ret=0
    case $state in
    (cargo-shuttle)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:cargo-shuttle-command-$line[1]:"
        case $line[1] in
            (deploy)
_arguments "${_arguments_options[@]}" \
'--allow-dirty[Allow deployment with uncommited files]' \
'--no-test[Don'\''t run pre-deploy tests]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(deployment)
_arguments "${_arguments_options[@]}" \
'-h[Print help]' \
'--help[Print help]' \
":: :_cargo-shuttle__deployment_commands" \
"*::: :->deployment" \
&& ret=0

    case $state in
    (deployment)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:cargo-shuttle-deployment-command-$line[1]:"
        case $line[1] in
            (list)
_arguments "${_arguments_options[@]}" \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(status)
_arguments "${_arguments_options[@]}" \
'-h[Print help]' \
'--help[Print help]' \
':id -- ID of deployment to get status for:' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" \
":: :_cargo-shuttle__deployment__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:cargo-shuttle-deployment-help-command-$line[1]:"
        case $line[1] in
            (list)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(status)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
;;
(resource)
_arguments "${_arguments_options[@]}" \
'-h[Print help]' \
'--help[Print help]' \
":: :_cargo-shuttle__resource_commands" \
"*::: :->resource" \
&& ret=0

    case $state in
    (resource)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:cargo-shuttle-resource-command-$line[1]:"
        case $line[1] in
            (list)
_arguments "${_arguments_options[@]}" \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" \
":: :_cargo-shuttle__resource__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:cargo-shuttle-resource-help-command-$line[1]:"
        case $line[1] in
            (list)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
;;
(init)
_arguments "${_arguments_options[@]}" \
'--api-key=[API key for the shuttle platform]:API_KEY: ' \
'(--axum --rocket --tide --tower --poem --serenity --poise --warp --salvo --thruster --no-framework)--actix_web[Initialize with actix-web framework]' \
'(--actix_web --rocket --tide --tower --poem --serenity --poise --warp --salvo --thruster --no-framework)--axum[Initialize with axum framework]' \
'(--actix_web --axum --tide --tower --poem --serenity --poise --warp --salvo --thruster --no-framework)--rocket[Initialize with rocket framework]' \
'(--actix_web --axum --rocket --tower --poem --serenity --poise --warp --salvo --thruster --no-framework)--tide[Initialize with tide framework]' \
'(--actix_web --axum --rocket --tide --poem --serenity --poise --warp --salvo --thruster --no-framework)--tower[Initialize with tower framework]' \
'(--actix_web --axum --rocket --tide --tower --serenity --poise --warp --salvo --thruster --no-framework)--poem[Initialize with poem framework]' \
'(--actix_web --axum --rocket --tide --tower --poem --warp --serenity --poise --thruster --no-framework)--salvo[Initialize with salvo framework]' \
'(--actix_web --axum --rocket --tide --tower --poem --warp --poise --salvo --thruster --no-framework)--serenity[Initialize with serenity framework]' \
'(--actix_web --axum --rocket --tide --tower --poem --warp --serenity --salvo --thruster --no-framework)--poise[Initialize with poise framework]' \
'(--actix_web --axum --rocket --tide --tower --poem --serenity --poise --salvo --thruster --no-framework)--warp[Initialize with warp framework]' \
'(--actix_web --axum --rocket --tide --tower --poem --warp --salvo --serenity --poise --no-framework)--thruster[Initialize with thruster framework]' \
'(--actix_web --axum --rocket --tide --tower --poem --warp --salvo --serenity --poise --thruster)--no-framework[Initialize without a framework]' \
'--new[Whether to create the environment for this project on shuttle]' \
'-h[Print help]' \
'--help[Print help]' \
'::path -- Path to initialize a new shuttle project:_files' \
&& ret=0
;;
(generate)
_arguments "${_arguments_options[@]}" \
'-s+[Which shell]:SHELL:(bash elvish fish powershell zsh)' \
'--shell=[Which shell]:SHELL:(bash elvish fish powershell zsh)' \
'-o+[Output to a file (stdout by default)]:OUTPUT:_files' \
'--output=[Output to a file (stdout by default)]:OUTPUT:_files' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(status)
_arguments "${_arguments_options[@]}" \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(logs)
_arguments "${_arguments_options[@]}" \
'-l[View logs from the most recent deployment (which is not always the latest running one)]' \
'--latest[View logs from the most recent deployment (which is not always the latest running one)]' \
'-f[Follow log output]' \
'--follow[Follow log output]' \
'-h[Print help]' \
'--help[Print help]' \
'::id -- Deployment ID to get logs for. Defaults to currently running deployment:' \
&& ret=0
;;
(clean)
_arguments "${_arguments_options[@]}" \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(stop)
_arguments "${_arguments_options[@]}" \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(secrets)
_arguments "${_arguments_options[@]}" \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(login)
_arguments "${_arguments_options[@]}" \
'--api-key=[API key for the shuttle platform]:API_KEY: ' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(logout)
_arguments "${_arguments_options[@]}" \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(run)
_arguments "${_arguments_options[@]}" \
'--port=[Port to start service on]:PORT: ' \
'--external[Use 0.0.0.0 instead of localhost (for usage with local external devices)]' \
'-r[Use release mode for building the project]' \
'--release[Use release mode for building the project]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(feedback)
_arguments "${_arguments_options[@]}" \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(project)
_arguments "${_arguments_options[@]}" \
'-h[Print help]' \
'--help[Print help]' \
":: :_cargo-shuttle__project_commands" \
"*::: :->project" \
&& ret=0

    case $state in
    (project)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:cargo-shuttle-project-command-$line[1]:"
        case $line[1] in
            (start)
_arguments "${_arguments_options[@]}" \
'--idle-minutes=[How long to wait before putting the project in an idle state due to inactivity. 0 means the project will never idle]:IDLE_MINUTES: ' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(status)
_arguments "${_arguments_options[@]}" \
'-f[Follow status of project command]' \
'--follow[Follow status of project command]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(stop)
_arguments "${_arguments_options[@]}" \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(restart)
_arguments "${_arguments_options[@]}" \
'--idle-minutes=[How long to wait before putting the project in an idle state due to inactivity. 0 means the project will never idle]:IDLE_MINUTES: ' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(list)
_arguments "${_arguments_options[@]}" \
'--filter=[Return projects filtered by a given project status]:FILTER: ' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" \
":: :_cargo-shuttle__project__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:cargo-shuttle-project-help-command-$line[1]:"
        case $line[1] in
            (start)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(status)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(stop)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(restart)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(list)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
;;
(help)
_arguments "${_arguments_options[@]}" \
":: :_cargo-shuttle__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:cargo-shuttle-help-command-$line[1]:"
        case $line[1] in
            (deploy)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(deployment)
_arguments "${_arguments_options[@]}" \
":: :_cargo-shuttle__help__deployment_commands" \
"*::: :->deployment" \
&& ret=0

    case $state in
    (deployment)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:cargo-shuttle-help-deployment-command-$line[1]:"
        case $line[1] in
            (list)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(status)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
        esac
    ;;
esac
;;
(resource)
_arguments "${_arguments_options[@]}" \
":: :_cargo-shuttle__help__resource_commands" \
"*::: :->resource" \
&& ret=0

    case $state in
    (resource)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:cargo-shuttle-help-resource-command-$line[1]:"
        case $line[1] in
            (list)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
        esac
    ;;
esac
;;
(init)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(generate)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(status)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(logs)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(clean)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(stop)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(secrets)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(login)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(logout)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(run)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(feedback)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(project)
_arguments "${_arguments_options[@]}" \
":: :_cargo-shuttle__help__project_commands" \
"*::: :->project" \
&& ret=0

    case $state in
    (project)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:cargo-shuttle-help-project-command-$line[1]:"
        case $line[1] in
            (start)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(status)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(stop)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(restart)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
(list)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
        esac
    ;;
esac
;;
(help)
_arguments "${_arguments_options[@]}" \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
}

(( $+functions[_cargo-shuttle_commands] )) ||
_cargo-shuttle_commands() {
    local commands; commands=(
'deploy:Deploy a shuttle service' \
'deployment:Manage deployments of a shuttle service' \
'resource:Manage resources of a shuttle project' \
'init:Create a new shuttle project' \
'generate:Generate shell completions' \
'status:View the status of a shuttle service' \
'logs:View the logs of a deployment in this shuttle service' \
'clean:Remove cargo build artifacts in the shuttle environment' \
'stop:Stop this shuttle service' \
'secrets:Manage secrets for this shuttle service' \
'login:Login to the shuttle platform' \
'logout:Log out of the shuttle platform' \
'run:Run a shuttle service locally' \
'feedback:Open an issue on GitHub and provide feedback' \
'project:List or manage projects on shuttle' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'cargo-shuttle commands' commands "$@"
}
(( $+functions[_cargo-shuttle__clean_commands] )) ||
_cargo-shuttle__clean_commands() {
    local commands; commands=()
    _describe -t commands 'cargo-shuttle clean commands' commands "$@"
}
(( $+functions[_cargo-shuttle__help__clean_commands] )) ||
_cargo-shuttle__help__clean_commands() {
    local commands; commands=()
    _describe -t commands 'cargo-shuttle help clean commands' commands "$@"
}
(( $+functions[_cargo-shuttle__deploy_commands] )) ||
_cargo-shuttle__deploy_commands() {
    local commands; commands=()
    _describe -t commands 'cargo-shuttle deploy commands' commands "$@"
}
(( $+functions[_cargo-shuttle__help__deploy_commands] )) ||
_cargo-shuttle__help__deploy_commands() {
    local commands; commands=()
    _describe -t commands 'cargo-shuttle help deploy commands' commands "$@"
}
(( $+functions[_cargo-shuttle__deployment_commands] )) ||
_cargo-shuttle__deployment_commands() {
    local commands; commands=(
'list:List all the deployments for a service' \
'status:View status of a deployment' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'cargo-shuttle deployment commands' commands "$@"
}
(( $+functions[_cargo-shuttle__help__deployment_commands] )) ||
_cargo-shuttle__help__deployment_commands() {
    local commands; commands=(
'list:List all the deployments for a service' \
'status:View status of a deployment' \
    )
    _describe -t commands 'cargo-shuttle help deployment commands' commands "$@"
}
(( $+functions[_cargo-shuttle__feedback_commands] )) ||
_cargo-shuttle__feedback_commands() {
    local commands; commands=()
    _describe -t commands 'cargo-shuttle feedback commands' commands "$@"
}
(( $+functions[_cargo-shuttle__help__feedback_commands] )) ||
_cargo-shuttle__help__feedback_commands() {
    local commands; commands=()
    _describe -t commands 'cargo-shuttle help feedback commands' commands "$@"
}
(( $+functions[_cargo-shuttle__generate_commands] )) ||
_cargo-shuttle__generate_commands() {
    local commands; commands=()
    _describe -t commands 'cargo-shuttle generate commands' commands "$@"
}
(( $+functions[_cargo-shuttle__help__generate_commands] )) ||
_cargo-shuttle__help__generate_commands() {
    local commands; commands=()
    _describe -t commands 'cargo-shuttle help generate commands' commands "$@"
}
(( $+functions[_cargo-shuttle__deployment__help_commands] )) ||
_cargo-shuttle__deployment__help_commands() {
    local commands; commands=(
'list:List all the deployments for a service' \
'status:View status of a deployment' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'cargo-shuttle deployment help commands' commands "$@"
}
(( $+functions[_cargo-shuttle__deployment__help__help_commands] )) ||
_cargo-shuttle__deployment__help__help_commands() {
    local commands; commands=()
    _describe -t commands 'cargo-shuttle deployment help help commands' commands "$@"
}
(( $+functions[_cargo-shuttle__help_commands] )) ||
_cargo-shuttle__help_commands() {
    local commands; commands=(
'deploy:Deploy a shuttle service' \
'deployment:Manage deployments of a shuttle service' \
'resource:Manage resources of a shuttle project' \
'init:Create a new shuttle project' \
'generate:Generate shell completions' \
'status:View the status of a shuttle service' \
'logs:View the logs of a deployment in this shuttle service' \
'clean:Remove cargo build artifacts in the shuttle environment' \
'stop:Stop this shuttle service' \
'secrets:Manage secrets for this shuttle service' \
'login:Login to the shuttle platform' \
'logout:Log out of the shuttle platform' \
'run:Run a shuttle service locally' \
'feedback:Open an issue on GitHub and provide feedback' \
'project:List or manage projects on shuttle' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'cargo-shuttle help commands' commands "$@"
}
(( $+functions[_cargo-shuttle__help__help_commands] )) ||
_cargo-shuttle__help__help_commands() {
    local commands; commands=()
    _describe -t commands 'cargo-shuttle help help commands' commands "$@"
}
(( $+functions[_cargo-shuttle__project__help_commands] )) ||
_cargo-shuttle__project__help_commands() {
    local commands; commands=(
'start:Create an environment for this project on shuttle' \
'status:Check the status of this project'\''s environment on shuttle' \
'stop:Destroy this project'\''s environment (container) on shuttle' \
'restart:Destroy and create an environment for this project on shuttle' \
'list:List all projects belonging to the calling account' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'cargo-shuttle project help commands' commands "$@"
}
(( $+functions[_cargo-shuttle__project__help__help_commands] )) ||
_cargo-shuttle__project__help__help_commands() {
    local commands; commands=()
    _describe -t commands 'cargo-shuttle project help help commands' commands "$@"
}
(( $+functions[_cargo-shuttle__resource__help_commands] )) ||
_cargo-shuttle__resource__help_commands() {
    local commands; commands=(
'list:List all the resources for a project' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'cargo-shuttle resource help commands' commands "$@"
}
(( $+functions[_cargo-shuttle__resource__help__help_commands] )) ||
_cargo-shuttle__resource__help__help_commands() {
    local commands; commands=()
    _describe -t commands 'cargo-shuttle resource help help commands' commands "$@"
}
(( $+functions[_cargo-shuttle__help__init_commands] )) ||
_cargo-shuttle__help__init_commands() {
    local commands; commands=()
    _describe -t commands 'cargo-shuttle help init commands' commands "$@"
}
(( $+functions[_cargo-shuttle__init_commands] )) ||
_cargo-shuttle__init_commands() {
    local commands; commands=()
    _describe -t commands 'cargo-shuttle init commands' commands "$@"
}
(( $+functions[_cargo-shuttle__deployment__help__list_commands] )) ||
_cargo-shuttle__deployment__help__list_commands() {
    local commands; commands=()
    _describe -t commands 'cargo-shuttle deployment help list commands' commands "$@"
}
(( $+functions[_cargo-shuttle__deployment__list_commands] )) ||
_cargo-shuttle__deployment__list_commands() {
    local commands; commands=()
    _describe -t commands 'cargo-shuttle deployment list commands' commands "$@"
}
(( $+functions[_cargo-shuttle__help__deployment__list_commands] )) ||
_cargo-shuttle__help__deployment__list_commands() {
    local commands; commands=()
    _describe -t commands 'cargo-shuttle help deployment list commands' commands "$@"
}
(( $+functions[_cargo-shuttle__help__project__list_commands] )) ||
_cargo-shuttle__help__project__list_commands() {
    local commands; commands=()
    _describe -t commands 'cargo-shuttle help project list commands' commands "$@"
}
(( $+functions[_cargo-shuttle__help__resource__list_commands] )) ||
_cargo-shuttle__help__resource__list_commands() {
    local commands; commands=()
    _describe -t commands 'cargo-shuttle help resource list commands' commands "$@"
}
(( $+functions[_cargo-shuttle__project__help__list_commands] )) ||
_cargo-shuttle__project__help__list_commands() {
    local commands; commands=()
    _describe -t commands 'cargo-shuttle project help list commands' commands "$@"
}
(( $+functions[_cargo-shuttle__project__list_commands] )) ||
_cargo-shuttle__project__list_commands() {
    local commands; commands=()
    _describe -t commands 'cargo-shuttle project list commands' commands "$@"
}
(( $+functions[_cargo-shuttle__resource__help__list_commands] )) ||
_cargo-shuttle__resource__help__list_commands() {
    local commands; commands=()
    _describe -t commands 'cargo-shuttle resource help list commands' commands "$@"
}
(( $+functions[_cargo-shuttle__resource__list_commands] )) ||
_cargo-shuttle__resource__list_commands() {
    local commands; commands=()
    _describe -t commands 'cargo-shuttle resource list commands' commands "$@"
}
(( $+functions[_cargo-shuttle__help__login_commands] )) ||
_cargo-shuttle__help__login_commands() {
    local commands; commands=()
    _describe -t commands 'cargo-shuttle help login commands' commands "$@"
}
(( $+functions[_cargo-shuttle__login_commands] )) ||
_cargo-shuttle__login_commands() {
    local commands; commands=()
    _describe -t commands 'cargo-shuttle login commands' commands "$@"
}
(( $+functions[_cargo-shuttle__help__logout_commands] )) ||
_cargo-shuttle__help__logout_commands() {
    local commands; commands=()
    _describe -t commands 'cargo-shuttle help logout commands' commands "$@"
}
(( $+functions[_cargo-shuttle__logout_commands] )) ||
_cargo-shuttle__logout_commands() {
    local commands; commands=()
    _describe -t commands 'cargo-shuttle logout commands' commands "$@"
}
(( $+functions[_cargo-shuttle__help__logs_commands] )) ||
_cargo-shuttle__help__logs_commands() {
    local commands; commands=()
    _describe -t commands 'cargo-shuttle help logs commands' commands "$@"
}
(( $+functions[_cargo-shuttle__logs_commands] )) ||
_cargo-shuttle__logs_commands() {
    local commands; commands=()
    _describe -t commands 'cargo-shuttle logs commands' commands "$@"
}
(( $+functions[_cargo-shuttle__help__project_commands] )) ||
_cargo-shuttle__help__project_commands() {
    local commands; commands=(
'start:Create an environment for this project on shuttle' \
'status:Check the status of this project'\''s environment on shuttle' \
'stop:Destroy this project'\''s environment (container) on shuttle' \
'restart:Destroy and create an environment for this project on shuttle' \
'list:List all projects belonging to the calling account' \
    )
    _describe -t commands 'cargo-shuttle help project commands' commands "$@"
}
(( $+functions[_cargo-shuttle__project_commands] )) ||
_cargo-shuttle__project_commands() {
    local commands; commands=(
'start:Create an environment for this project on shuttle' \
'status:Check the status of this project'\''s environment on shuttle' \
'stop:Destroy this project'\''s environment (container) on shuttle' \
'restart:Destroy and create an environment for this project on shuttle' \
'list:List all projects belonging to the calling account' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'cargo-shuttle project commands' commands "$@"
}
(( $+functions[_cargo-shuttle__help__resource_commands] )) ||
_cargo-shuttle__help__resource_commands() {
    local commands; commands=(
'list:List all the resources for a project' \
    )
    _describe -t commands 'cargo-shuttle help resource commands' commands "$@"
}
(( $+functions[_cargo-shuttle__resource_commands] )) ||
_cargo-shuttle__resource_commands() {
    local commands; commands=(
'list:List all the resources for a project' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'cargo-shuttle resource commands' commands "$@"
}
(( $+functions[_cargo-shuttle__help__project__restart_commands] )) ||
_cargo-shuttle__help__project__restart_commands() {
    local commands; commands=()
    _describe -t commands 'cargo-shuttle help project restart commands' commands "$@"
}
(( $+functions[_cargo-shuttle__project__help__restart_commands] )) ||
_cargo-shuttle__project__help__restart_commands() {
    local commands; commands=()
    _describe -t commands 'cargo-shuttle project help restart commands' commands "$@"
}
(( $+functions[_cargo-shuttle__project__restart_commands] )) ||
_cargo-shuttle__project__restart_commands() {
    local commands; commands=()
    _describe -t commands 'cargo-shuttle project restart commands' commands "$@"
}
(( $+functions[_cargo-shuttle__help__run_commands] )) ||
_cargo-shuttle__help__run_commands() {
    local commands; commands=()
    _describe -t commands 'cargo-shuttle help run commands' commands "$@"
}
(( $+functions[_cargo-shuttle__run_commands] )) ||
_cargo-shuttle__run_commands() {
    local commands; commands=()
    _describe -t commands 'cargo-shuttle run commands' commands "$@"
}
(( $+functions[_cargo-shuttle__help__secrets_commands] )) ||
_cargo-shuttle__help__secrets_commands() {
    local commands; commands=()
    _describe -t commands 'cargo-shuttle help secrets commands' commands "$@"
}
(( $+functions[_cargo-shuttle__secrets_commands] )) ||
_cargo-shuttle__secrets_commands() {
    local commands; commands=()
    _describe -t commands 'cargo-shuttle secrets commands' commands "$@"
}
(( $+functions[_cargo-shuttle__help__project__start_commands] )) ||
_cargo-shuttle__help__project__start_commands() {
    local commands; commands=()
    _describe -t commands 'cargo-shuttle help project start commands' commands "$@"
}
(( $+functions[_cargo-shuttle__project__help__start_commands] )) ||
_cargo-shuttle__project__help__start_commands() {
    local commands; commands=()
    _describe -t commands 'cargo-shuttle project help start commands' commands "$@"
}
(( $+functions[_cargo-shuttle__project__start_commands] )) ||
_cargo-shuttle__project__start_commands() {
    local commands; commands=()
    _describe -t commands 'cargo-shuttle project start commands' commands "$@"
}
(( $+functions[_cargo-shuttle__deployment__help__status_commands] )) ||
_cargo-shuttle__deployment__help__status_commands() {
    local commands; commands=()
    _describe -t commands 'cargo-shuttle deployment help status commands' commands "$@"
}
(( $+functions[_cargo-shuttle__deployment__status_commands] )) ||
_cargo-shuttle__deployment__status_commands() {
    local commands; commands=()
    _describe -t commands 'cargo-shuttle deployment status commands' commands "$@"
}
(( $+functions[_cargo-shuttle__help__deployment__status_commands] )) ||
_cargo-shuttle__help__deployment__status_commands() {
    local commands; commands=()
    _describe -t commands 'cargo-shuttle help deployment status commands' commands "$@"
}
(( $+functions[_cargo-shuttle__help__project__status_commands] )) ||
_cargo-shuttle__help__project__status_commands() {
    local commands; commands=()
    _describe -t commands 'cargo-shuttle help project status commands' commands "$@"
}
(( $+functions[_cargo-shuttle__help__status_commands] )) ||
_cargo-shuttle__help__status_commands() {
    local commands; commands=()
    _describe -t commands 'cargo-shuttle help status commands' commands "$@"
}
(( $+functions[_cargo-shuttle__project__help__status_commands] )) ||
_cargo-shuttle__project__help__status_commands() {
    local commands; commands=()
    _describe -t commands 'cargo-shuttle project help status commands' commands "$@"
}
(( $+functions[_cargo-shuttle__project__status_commands] )) ||
_cargo-shuttle__project__status_commands() {
    local commands; commands=()
    _describe -t commands 'cargo-shuttle project status commands' commands "$@"
}
(( $+functions[_cargo-shuttle__status_commands] )) ||
_cargo-shuttle__status_commands() {
    local commands; commands=()
    _describe -t commands 'cargo-shuttle status commands' commands "$@"
}
(( $+functions[_cargo-shuttle__help__project__stop_commands] )) ||
_cargo-shuttle__help__project__stop_commands() {
    local commands; commands=()
    _describe -t commands 'cargo-shuttle help project stop commands' commands "$@"
}
(( $+functions[_cargo-shuttle__help__stop_commands] )) ||
_cargo-shuttle__help__stop_commands() {
    local commands; commands=()
    _describe -t commands 'cargo-shuttle help stop commands' commands "$@"
}
(( $+functions[_cargo-shuttle__project__help__stop_commands] )) ||
_cargo-shuttle__project__help__stop_commands() {
    local commands; commands=()
    _describe -t commands 'cargo-shuttle project help stop commands' commands "$@"
}
(( $+functions[_cargo-shuttle__project__stop_commands] )) ||
_cargo-shuttle__project__stop_commands() {
    local commands; commands=()
    _describe -t commands 'cargo-shuttle project stop commands' commands "$@"
}
(( $+functions[_cargo-shuttle__stop_commands] )) ||
_cargo-shuttle__stop_commands() {
    local commands; commands=()
    _describe -t commands 'cargo-shuttle stop commands' commands "$@"
}

if [ "$funcstack[1]" = "_cargo-shuttle" ]; then
    _cargo-shuttle "$@"
else
    compdef _cargo-shuttle cargo-shuttle
fi
