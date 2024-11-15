mod tests {
    use snforge_std::{declare, ContractClassTrait, DeclareResultTrait};
    use snfoundry_basics::simple_contract::{
        ISimpleContractDispatcher, ISimpleContractDispatcherTrait
    };

    use snfoundry_basics::simple_vault::ISimpleVaultDispatcher;
    use snfoundry_basics::simple_vault::ISimpleVaultDispatcherTrait;
    use snfoundry_basics::simple_vault::ISimpleVaultSafeDispatcher;
    use snfoundry_basics::simple_vault::ISimpleVaultSafeDispatcherTrait;

    #[test]
    fn call_and_invoke() {
        // First declare and deploy a contract
        let contract = declare("SimpleContract").unwrap().contract_class();
        // Alternatively we could use `deploy_syscall` here
        let (contract_address, _) = contract.deploy(@array![]).unwrap();

        // Create a Dispatcher object that will allow interacting with the deployed contract
        let dispatcher = ISimpleContractDispatcher { contract_address };

        // Call a view function of the contract
        let balance = dispatcher.get_balance();
        assert(balance == 0, 'balance == 0');

        // Call a function of the contract
        // Here we mutate the state of the storage
        dispatcher.increase_balance(100);

        // Check that transaction took effect
        let balance = dispatcher.get_balance();
        assert(balance == 100, 'balance == 100');
    }

    #[test]
    fn call_and_invoke_vault() {
        // First declare and deploy contract
        let contract = declare("SimpleVault").unwrap().contract_class();
        // Alternatively we could use `deploy_syscall` here
        let (contract_address, _) = contract.deploy(@array![1]).unwrap();
        println!("Contract address is: {:?}", contract_address);
        // Create a Dispatcher object that will allow interaction with the deployed contract
        let dispatcher = ISimpleVaultDispatcher { contract_address };
        println!("hi");
        // Call a view function of the contract
        let version = dispatcher.get_vault_version();
        println!("hi-1");
        println!("version: {:?}", version);
        assert(version == 1, 'error');
    }
}

