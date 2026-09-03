## IAM stands for Identity and Access Management.

### It controls:

Who can access AWS, what they can do and which resources they can use.

| IAM concept            | Simple meaning                                                 |
| ---------------------- | -------------------------------------------------------------- |
| **User**               | An individual AWS identity, usually created for one person     |
| **Group**              | A collection of users who need similar permissions             |
| **Policy**             | JSON rules stating which actions are allowed or denied         |
| **Role**               | Temporary permissions that a trusted person or service can use |
| **Password policy**    | Rules for IAM users’ passwords                                 |
| **MFA**                | An additional security check during sign-in                    |
| **Access keys**        | Credentials used for programmatic access                       |
| **Credentials Report** | Account-wide report about IAM users’ credentials               |
| **Access Advisor**     | Shows permitted services and when they were last accessed      |


A policy defines:

Effect: allow or deny
Action: what can be done
Resource: which AWS resource it applies to
Condition: optional requirements

A role can be assumed by a trusted AWS service or person. It provides temporary credentials.

For example, an EC2 instance can use a role to read from S3 without storing permanent access keys.

Groups do not receive roles directly. A group policy can allow its users to assume a role.

Ways to manage AWS
Console: manage AWS by clicking.
CLI: manage AWS using terminal commands.
SDK: interact with AWS from application code.
Terraform: a third-party infrastructure-as-code tool that can create and manage AWS resources.

CLI, SDK and Terraform can use access keys, but temporary credentials through SSO or IAM roles are preferred.

Security rules to remember
Protect the root user with MFA and avoid using it routinely.
Enable MFA for human access.
Give only the minimum permissions needed.
Use IAM roles for applications and AWS services.
Never share or commit access keys to GitHub.
Review credentials and permissions regularly.
The main idea to remember

Identity says who. Policy says what. Resource says where. Role provides temporary access. MFA protects sign-in.

## Creating a Policy, attaching it a to a Role, attach Policy to User Group

Open the IAM service in AWS.
Go to Policies and select Create policy.
Choose which AWS services the policy should cover:
IAM
Lambda
Choose the actions to allow. In the demonstration, all IAM and Lambda actions were allowed.
Choose which resources the actions can affect. The demonstration selected all resources.
Review the policy in JSON format.
Give the policy a name, such as test-compute-policy.
Create the policy. It will appear as a customer-managed policy because you created it yourself.
Go to Roles and create a new role.
Choose who or what is allowed to use the role.
Attach the newly created policy to the role.
Give the role a name and create it.
To give the same permissions to users, go to User groups.
Select the group and open Permissions.
Choose Attach policy.
Find the custom policy and attach it to the group.
Every user in that group will then receive the permissions contained in the policy.

Important correction: the policy was attached to the role and separately to the user group. The role itself was not assigned to the user group. Also, allowing every action on every resource is extremely powerful and was only done for demonstration; normally, you should allow only the specific actions and resources required.