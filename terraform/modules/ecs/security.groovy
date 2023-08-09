// import org.jenkinsci.plugins.scriptsecurity.scripts.ScriptApproval
//
// ScriptApproval scriptApproval = ScriptApproval.get()
// scriptApproval.pendingScripts.each {
//     scriptApproval.approveScript(it.hash)
// }


import javaposse.jobdsl.plugin.GlobalJobDslSecurityConfiguration
import jenkins.model.GlobalConfiguration

// disable Job DSL script approval
GlobalConfiguration.all().get(GlobalJobDslSecurityConfiguration.class).useScriptSecurity=false
GlobalConfiguration.all().get(GlobalJobDslSecurityConfiguration.class).save()

// disable CSFR protection causing issues with github webhook integration
import jenkins.model.Jenkins
def instance = Jenkins.instance
instance.setCrumbIssuer(null)
