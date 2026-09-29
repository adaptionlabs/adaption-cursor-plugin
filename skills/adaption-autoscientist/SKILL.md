---
name: adaption-autoscientist
description: Run AutoScientist workflows for automated dataset creation and optimization. 
  Use when you need AI-generated datasets or want to optimize existing ones.
---

# Adaption AutoScientist Skill

Run AutoScientist workflows for automated dataset generation and optimization.

## When to use

- Generate synthetic training datasets from specifications
- Create domain-specific datasets using Invent
- Optimize and augment existing datasets
- Explore available data generation domains

## Available MCP Tools

| Tool | Description |
|------|-------------|
| `adaption_list_invent_domains` | List available domains for data generation |
| `adaption_launch_invent` | Start synthetic data generation |
| `adaption_get_invent_status` | Check generation progress |
| `adaption_launch_autoscientist` | Run full AutoScientist optimization |

## Example Workflows

### Generate domain-specific training data

1. Call `adaption_list_invent_domains` to explore available domains
2. Choose a domain and subdomain matching your use case
3. Call `adaption_launch_invent` with:
   - `domain`: Selected domain code
   - `subdomain`: Selected subdomain code
   - `num_samples`: Number of samples to generate
   - `specifications`: Custom requirements for the data
4. Poll `adaption_get_invent_status` until generation completes
5. Result is a new dataset ready for adaptation and training

### Run AutoScientist on existing data

1. Have an adapted dataset ready
2. Call `adaption_launch_autoscientist` with:
   - `dataset_id`: Source dataset
   - `objective`: Optimization goal
   - `constraints`: Any constraints on the output
3. AutoScientist analyzes and optimizes the dataset
4. Results include optimized data and recommendations

## Available Domains

Domains span many categories including:

- **Technology**: Software development, APIs, DevOps
- **Business**: Customer service, sales, marketing
- **Science**: Research, analysis, methodology
- **Education**: Tutoring, explanations, assessments
- **Creative**: Writing, content creation

Use `adaption_list_invent_domains` to see the full catalog with subdomains.

## Tips

- Be specific in your specifications for better results
- Start with smaller sample sizes to validate quality
- Generated data works best when combined with real examples
- AutoScientist can identify data gaps and suggest improvements
