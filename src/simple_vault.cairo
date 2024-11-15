#[starknet::interface]
pub trait ISimpleVault<TContractState> {
    // fn constructor(ref self:TContractState,version:felt252);
    fn get_vault_version(self: @TContractState) -> felt252;
}

#[starknet::contract]
pub mod SimpleVault {
    use super::ISimpleVault;

    #[storage]
    struct Storage {
        version: felt252
    }

    #[abi(embed_v0)]
    pub impl SimpleVaultImpl of ISimpleVault<ContractState> {
        fn get_vault_version(self: @ContractState) -> felt252 {
            self.version.read()
        }
    }

    #[constructor]
    fn constructor(ref self: ContractState, version: felt252) {
        self.version.write(version);
    }
}
