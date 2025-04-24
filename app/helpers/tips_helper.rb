module TipsHelper
  def model_tips
    {
      devices: [
        { label: "Brand", content: "Doesn't capitalize automatically." },
        { label: "Device type", content: "Buds are wearables and cables accessories." },
        { label: "TAT", content: "Satisfied is automatically set as less than neutral." }
      ],
      statuses: [
        { label: "Caution", content: "Before proceeding. Please make sure there isn't another status with the same meaning." },
        { label: "Caution", content: "You cannot edit the status name later or delete it. Therefore, choose carefully and make checks before proceeding." },
        { label: "Active", content: "True means the status will be available for use immediately. False makes it unavailable. It can be changed later." }
      ],
      inventories: [
        { label: "Description", content: "[part] - [brand] [model]" },
        { label: "IMEI", content: "Can be left blank if serial is filled" },
        { label: "Serial", content: "Can be left blank if IMEI is filled" },
        { label: "Location", content: "The shelf the part will be put on." }
      ],
      users: [
        { label: "Name", content: "Enter middlename if another with the same name exists." },
        { label: "Email", content: "RD doesn't create email addresses. Therefore make sure one is created beforehand." },
        { label: "Password", content: "Enter an easy temporary password." },
        { label: "Role", content: "Do not select a higher role than necessary. Choose the lowest role that meets the user's needs." }
      ],
      repairs: [
        { label: "Caution", content: "Always double-check email and phone before submitting." },
        { label: "Error description", content: "Make it short and concise. Add how to recreate the error. if not obvious." },
        { label: "IMEI & Serial", content: "Either one needs to be provided. Both cannot be empty. Customer must solve this before submitting a repair." }
      ]
    }
  end

  #  Method to get tips for a specific model
  def tips_for(model)
    model_tips[model.to_sym] || []
  end
end
