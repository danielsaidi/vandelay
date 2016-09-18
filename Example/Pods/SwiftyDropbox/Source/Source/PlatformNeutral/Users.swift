///
/// Copyright (c) 2016 Dropbox, Inc. All rights reserved.
///
/// Auto-generated by Stone, do not modify.
///

import Foundation

/// Datatypes and serializers for the users namespace
public class Users {
    /// The amount of detail revealed about an account depends on the user being queried and the user making the query.
    public class Account: CustomStringConvertible {
        /// The user's unique Dropbox ID.
        public let accountId: String
        /// Details of a user's name.
        public let name: Users.Name
        /// The user's e-mail address. Do not rely on this without checking the emailVerified field. Even then, it's
        /// possible that the user has since lost access to their e-mail.
        public let email: String
        /// Whether the user has verified their e-mail address.
        public let emailVerified: Bool
        /// URL for the photo representing the user, if one is set.
        public let profilePhotoUrl: String?
        /// Whether the user has been disabled.
        public let disabled: Bool
        public init(accountId: String, name: Users.Name, email: String, emailVerified: Bool, disabled: Bool, profilePhotoUrl: String? = nil) {
            stringValidator(minLength: 40, maxLength: 40)(accountId)
            self.accountId = accountId
            self.name = name
            stringValidator()(email)
            self.email = email
            self.emailVerified = emailVerified
            nullableValidator(stringValidator())(profilePhotoUrl)
            self.profilePhotoUrl = profilePhotoUrl
            self.disabled = disabled
        }
        public var description: String {
            return "\(SerializeUtil.prepareJSONForSerialization(AccountSerializer().serialize(self)))"
        }
    }
    public class AccountSerializer: JSONSerializer {
        public init() { }
        public func serialize(_ value: Account) -> JSON {
            let output = [ 
            "account_id": Serialization._StringSerializer.serialize(value.accountId),
            "name": Users.NameSerializer().serialize(value.name),
            "email": Serialization._StringSerializer.serialize(value.email),
            "email_verified": Serialization._BoolSerializer.serialize(value.emailVerified),
            "disabled": Serialization._BoolSerializer.serialize(value.disabled),
            "profile_photo_url": NullableSerializer(Serialization._StringSerializer).serialize(value.profilePhotoUrl),
            ]
            return .dictionary(output)
        }
        public func deserialize(_ json: JSON) -> Account {
            switch json {
                case .dictionary(let dict):
                    let accountId = Serialization._StringSerializer.deserialize(dict["account_id"] ?? .null)
                    let name = Users.NameSerializer().deserialize(dict["name"] ?? .null)
                    let email = Serialization._StringSerializer.deserialize(dict["email"] ?? .null)
                    let emailVerified = Serialization._BoolSerializer.deserialize(dict["email_verified"] ?? .null)
                    let disabled = Serialization._BoolSerializer.deserialize(dict["disabled"] ?? .null)
                    let profilePhotoUrl = NullableSerializer(Serialization._StringSerializer).deserialize(dict["profile_photo_url"] ?? .null)
                    return Account(accountId: accountId, name: name, email: email, emailVerified: emailVerified, disabled: disabled, profilePhotoUrl: profilePhotoUrl)
                default:
                    fatalError("Type error deserializing")
            }
        }
    }

    /// What type of account this user has.
    public enum AccountType: CustomStringConvertible {
        /// The basic account type.
        case basic
        /// The Dropbox Pro account type.
        case pro
        /// The Dropbox Business account type.
        case business

        public var description: String {
            return "\(SerializeUtil.prepareJSONForSerialization(AccountTypeSerializer().serialize(self)))"
        }
    }
    public class AccountTypeSerializer: JSONSerializer {
        public init() { }
        public func serialize(_ value: AccountType) -> JSON {
            switch value {
                case .basic:
                    var d = [String: JSON]()
                    d[".tag"] = .str("basic")
                    return .dictionary(d)
                case .pro:
                    var d = [String: JSON]()
                    d[".tag"] = .str("pro")
                    return .dictionary(d)
                case .business:
                    var d = [String: JSON]()
                    d[".tag"] = .str("business")
                    return .dictionary(d)
            }
        }
        public func deserialize(_ json: JSON) -> AccountType {
            switch json {
                case .dictionary(let d):
                    let tag = Serialization.getTag(d)
                    switch tag {
                        case "basic":
                            return AccountType.basic
                        case "pro":
                            return AccountType.pro
                        case "business":
                            return AccountType.business
                        default:
                            fatalError("Unknown tag \(tag)")
                    }
                default:
                    fatalError("Failed to deserialize")
            }
        }
    }

    /// Basic information about any account.
    public class BasicAccount: Users.Account {
        /// Whether this user is a teammate of the current user. If this account is the current user's account, then
        /// this will be true.
        public let isTeammate: Bool
        /// The user's unique team member id. This field will only be present if the user is part of a team and
        /// isTeammate is true.
        public let teamMemberId: String?
        public init(accountId: String, name: Users.Name, email: String, emailVerified: Bool, disabled: Bool, isTeammate: Bool, profilePhotoUrl: String? = nil, teamMemberId: String? = nil) {
            self.isTeammate = isTeammate
            nullableValidator(stringValidator())(teamMemberId)
            self.teamMemberId = teamMemberId
            super.init(accountId: accountId, name: name, email: email, emailVerified: emailVerified, disabled: disabled, profilePhotoUrl: profilePhotoUrl)
        }
        public override var description: String {
            return "\(SerializeUtil.prepareJSONForSerialization(BasicAccountSerializer().serialize(self)))"
        }
    }
    public class BasicAccountSerializer: JSONSerializer {
        public init() { }
        public func serialize(_ value: BasicAccount) -> JSON {
            let output = [ 
            "account_id": Serialization._StringSerializer.serialize(value.accountId),
            "name": Users.NameSerializer().serialize(value.name),
            "email": Serialization._StringSerializer.serialize(value.email),
            "email_verified": Serialization._BoolSerializer.serialize(value.emailVerified),
            "disabled": Serialization._BoolSerializer.serialize(value.disabled),
            "is_teammate": Serialization._BoolSerializer.serialize(value.isTeammate),
            "profile_photo_url": NullableSerializer(Serialization._StringSerializer).serialize(value.profilePhotoUrl),
            "team_member_id": NullableSerializer(Serialization._StringSerializer).serialize(value.teamMemberId),
            ]
            return .dictionary(output)
        }
        public func deserialize(_ json: JSON) -> BasicAccount {
            switch json {
                case .dictionary(let dict):
                    let accountId = Serialization._StringSerializer.deserialize(dict["account_id"] ?? .null)
                    let name = Users.NameSerializer().deserialize(dict["name"] ?? .null)
                    let email = Serialization._StringSerializer.deserialize(dict["email"] ?? .null)
                    let emailVerified = Serialization._BoolSerializer.deserialize(dict["email_verified"] ?? .null)
                    let disabled = Serialization._BoolSerializer.deserialize(dict["disabled"] ?? .null)
                    let isTeammate = Serialization._BoolSerializer.deserialize(dict["is_teammate"] ?? .null)
                    let profilePhotoUrl = NullableSerializer(Serialization._StringSerializer).deserialize(dict["profile_photo_url"] ?? .null)
                    let teamMemberId = NullableSerializer(Serialization._StringSerializer).deserialize(dict["team_member_id"] ?? .null)
                    return BasicAccount(accountId: accountId, name: name, email: email, emailVerified: emailVerified, disabled: disabled, isTeammate: isTeammate, profilePhotoUrl: profilePhotoUrl, teamMemberId: teamMemberId)
                default:
                    fatalError("Type error deserializing")
            }
        }
    }

    /// Detailed information about the current user's account.
    public class FullAccount: Users.Account {
        /// The user's two-letter country code, if available. Country codes are based on ISO 3166-1
        /// http://en.wikipedia.org/wiki/ISO_3166-1.
        public let country: String?
        /// The language that the user specified. Locale tags will be IETF language tags
        /// http://en.wikipedia.org/wiki/IETF_language_tag.
        public let locale: String
        /// The user's referral link https://www.dropbox.com/referrals.
        public let referralLink: String
        /// If this account is a member of a team, information about that team.
        public let team: Users.FullTeam?
        /// This account's unique team member id. This field will only be present if team is present.
        public let teamMemberId: String?
        /// Whether the user has a personal and work account. If the current account is personal, then team will always
        /// be null, but isPaired will indicate if a work account is linked.
        public let isPaired: Bool
        /// What type of account this user has.
        public let accountType: Users.AccountType
        public init(accountId: String, name: Users.Name, email: String, emailVerified: Bool, disabled: Bool, locale: String, referralLink: String, isPaired: Bool, accountType: Users.AccountType, profilePhotoUrl: String? = nil, country: String? = nil, team: Users.FullTeam? = nil, teamMemberId: String? = nil) {
            nullableValidator(stringValidator(minLength: 2, maxLength: 2))(country)
            self.country = country
            stringValidator(minLength: 2)(locale)
            self.locale = locale
            stringValidator()(referralLink)
            self.referralLink = referralLink
            self.team = team
            nullableValidator(stringValidator())(teamMemberId)
            self.teamMemberId = teamMemberId
            self.isPaired = isPaired
            self.accountType = accountType
            super.init(accountId: accountId, name: name, email: email, emailVerified: emailVerified, disabled: disabled, profilePhotoUrl: profilePhotoUrl)
        }
        public override var description: String {
            return "\(SerializeUtil.prepareJSONForSerialization(FullAccountSerializer().serialize(self)))"
        }
    }
    public class FullAccountSerializer: JSONSerializer {
        public init() { }
        public func serialize(_ value: FullAccount) -> JSON {
            let output = [ 
            "account_id": Serialization._StringSerializer.serialize(value.accountId),
            "name": Users.NameSerializer().serialize(value.name),
            "email": Serialization._StringSerializer.serialize(value.email),
            "email_verified": Serialization._BoolSerializer.serialize(value.emailVerified),
            "disabled": Serialization._BoolSerializer.serialize(value.disabled),
            "locale": Serialization._StringSerializer.serialize(value.locale),
            "referral_link": Serialization._StringSerializer.serialize(value.referralLink),
            "is_paired": Serialization._BoolSerializer.serialize(value.isPaired),
            "account_type": Users.AccountTypeSerializer().serialize(value.accountType),
            "profile_photo_url": NullableSerializer(Serialization._StringSerializer).serialize(value.profilePhotoUrl),
            "country": NullableSerializer(Serialization._StringSerializer).serialize(value.country),
            "team": NullableSerializer(Users.FullTeamSerializer()).serialize(value.team),
            "team_member_id": NullableSerializer(Serialization._StringSerializer).serialize(value.teamMemberId),
            ]
            return .dictionary(output)
        }
        public func deserialize(_ json: JSON) -> FullAccount {
            switch json {
                case .dictionary(let dict):
                    let accountId = Serialization._StringSerializer.deserialize(dict["account_id"] ?? .null)
                    let name = Users.NameSerializer().deserialize(dict["name"] ?? .null)
                    let email = Serialization._StringSerializer.deserialize(dict["email"] ?? .null)
                    let emailVerified = Serialization._BoolSerializer.deserialize(dict["email_verified"] ?? .null)
                    let disabled = Serialization._BoolSerializer.deserialize(dict["disabled"] ?? .null)
                    let locale = Serialization._StringSerializer.deserialize(dict["locale"] ?? .null)
                    let referralLink = Serialization._StringSerializer.deserialize(dict["referral_link"] ?? .null)
                    let isPaired = Serialization._BoolSerializer.deserialize(dict["is_paired"] ?? .null)
                    let accountType = Users.AccountTypeSerializer().deserialize(dict["account_type"] ?? .null)
                    let profilePhotoUrl = NullableSerializer(Serialization._StringSerializer).deserialize(dict["profile_photo_url"] ?? .null)
                    let country = NullableSerializer(Serialization._StringSerializer).deserialize(dict["country"] ?? .null)
                    let team = NullableSerializer(Users.FullTeamSerializer()).deserialize(dict["team"] ?? .null)
                    let teamMemberId = NullableSerializer(Serialization._StringSerializer).deserialize(dict["team_member_id"] ?? .null)
                    return FullAccount(accountId: accountId, name: name, email: email, emailVerified: emailVerified, disabled: disabled, locale: locale, referralLink: referralLink, isPaired: isPaired, accountType: accountType, profilePhotoUrl: profilePhotoUrl, country: country, team: team, teamMemberId: teamMemberId)
                default:
                    fatalError("Type error deserializing")
            }
        }
    }

    /// Information about a team.
    public class Team: CustomStringConvertible {
        /// The team's unique ID.
        public let id: String
        /// The name of the team.
        public let name: String
        public init(id: String, name: String) {
            stringValidator()(id)
            self.id = id
            stringValidator()(name)
            self.name = name
        }
        public var description: String {
            return "\(SerializeUtil.prepareJSONForSerialization(TeamSerializer().serialize(self)))"
        }
    }
    public class TeamSerializer: JSONSerializer {
        public init() { }
        public func serialize(_ value: Team) -> JSON {
            let output = [ 
            "id": Serialization._StringSerializer.serialize(value.id),
            "name": Serialization._StringSerializer.serialize(value.name),
            ]
            return .dictionary(output)
        }
        public func deserialize(_ json: JSON) -> Team {
            switch json {
                case .dictionary(let dict):
                    let id = Serialization._StringSerializer.deserialize(dict["id"] ?? .null)
                    let name = Serialization._StringSerializer.deserialize(dict["name"] ?? .null)
                    return Team(id: id, name: name)
                default:
                    fatalError("Type error deserializing")
            }
        }
    }

    /// Detailed information about a team.
    public class FullTeam: Users.Team {
        /// Team policies governing sharing.
        public let sharingPolicies: TeamPolicies.TeamSharingPolicies
        public init(id: String, name: String, sharingPolicies: TeamPolicies.TeamSharingPolicies) {
            self.sharingPolicies = sharingPolicies
            super.init(id: id, name: name)
        }
        public override var description: String {
            return "\(SerializeUtil.prepareJSONForSerialization(FullTeamSerializer().serialize(self)))"
        }
    }
    public class FullTeamSerializer: JSONSerializer {
        public init() { }
        public func serialize(_ value: FullTeam) -> JSON {
            let output = [ 
            "id": Serialization._StringSerializer.serialize(value.id),
            "name": Serialization._StringSerializer.serialize(value.name),
            "sharing_policies": TeamPolicies.TeamSharingPoliciesSerializer().serialize(value.sharingPolicies),
            ]
            return .dictionary(output)
        }
        public func deserialize(_ json: JSON) -> FullTeam {
            switch json {
                case .dictionary(let dict):
                    let id = Serialization._StringSerializer.deserialize(dict["id"] ?? .null)
                    let name = Serialization._StringSerializer.deserialize(dict["name"] ?? .null)
                    let sharingPolicies = TeamPolicies.TeamSharingPoliciesSerializer().deserialize(dict["sharing_policies"] ?? .null)
                    return FullTeam(id: id, name: name, sharingPolicies: sharingPolicies)
                default:
                    fatalError("Type error deserializing")
            }
        }
    }

    /// The GetAccountArg struct
    public class GetAccountArg: CustomStringConvertible {
        /// A user's account identifier.
        public let accountId: String
        public init(accountId: String) {
            stringValidator(minLength: 40, maxLength: 40)(accountId)
            self.accountId = accountId
        }
        public var description: String {
            return "\(SerializeUtil.prepareJSONForSerialization(GetAccountArgSerializer().serialize(self)))"
        }
    }
    public class GetAccountArgSerializer: JSONSerializer {
        public init() { }
        public func serialize(_ value: GetAccountArg) -> JSON {
            let output = [ 
            "account_id": Serialization._StringSerializer.serialize(value.accountId),
            ]
            return .dictionary(output)
        }
        public func deserialize(_ json: JSON) -> GetAccountArg {
            switch json {
                case .dictionary(let dict):
                    let accountId = Serialization._StringSerializer.deserialize(dict["account_id"] ?? .null)
                    return GetAccountArg(accountId: accountId)
                default:
                    fatalError("Type error deserializing")
            }
        }
    }

    /// The GetAccountBatchArg struct
    public class GetAccountBatchArg: CustomStringConvertible {
        /// List of user account identifiers.  Should not contain any duplicate account IDs.
        public let accountIds: Array<String>
        public init(accountIds: Array<String>) {
            arrayValidator(minItems: 1, itemValidator: stringValidator(minLength: 40, maxLength: 40))(accountIds)
            self.accountIds = accountIds
        }
        public var description: String {
            return "\(SerializeUtil.prepareJSONForSerialization(GetAccountBatchArgSerializer().serialize(self)))"
        }
    }
    public class GetAccountBatchArgSerializer: JSONSerializer {
        public init() { }
        public func serialize(_ value: GetAccountBatchArg) -> JSON {
            let output = [ 
            "account_ids": ArraySerializer(Serialization._StringSerializer).serialize(value.accountIds),
            ]
            return .dictionary(output)
        }
        public func deserialize(_ json: JSON) -> GetAccountBatchArg {
            switch json {
                case .dictionary(let dict):
                    let accountIds = ArraySerializer(Serialization._StringSerializer).deserialize(dict["account_ids"] ?? .null)
                    return GetAccountBatchArg(accountIds: accountIds)
                default:
                    fatalError("Type error deserializing")
            }
        }
    }

    /// The GetAccountBatchError union
    public enum GetAccountBatchError: CustomStringConvertible {
        /// The value is an account ID specified in accountIds in GetAccountBatchArg that does not exist.
        case noAccount(String)
        /// An unspecified error.
        case other

        public var description: String {
            return "\(SerializeUtil.prepareJSONForSerialization(GetAccountBatchErrorSerializer().serialize(self)))"
        }
    }
    public class GetAccountBatchErrorSerializer: JSONSerializer {
        public init() { }
        public func serialize(_ value: GetAccountBatchError) -> JSON {
            switch value {
                case .noAccount(let arg):
                    var d = ["no_account": Serialization._StringSerializer.serialize(arg)]
                    d[".tag"] = .str("no_account")
                    return .dictionary(d)
                case .other:
                    var d = [String: JSON]()
                    d[".tag"] = .str("other")
                    return .dictionary(d)
            }
        }
        public func deserialize(_ json: JSON) -> GetAccountBatchError {
            switch json {
                case .dictionary(let d):
                    let tag = Serialization.getTag(d)
                    switch tag {
                        case "no_account":
                            let v = Serialization._StringSerializer.deserialize(d["no_account"] ?? .null)
                            return GetAccountBatchError.noAccount(v)
                        case "other":
                            return GetAccountBatchError.other
                        default:
                            return GetAccountBatchError.other
                    }
                default:
                    fatalError("Failed to deserialize")
            }
        }
    }

    /// The GetAccountError union
    public enum GetAccountError: CustomStringConvertible {
        /// The specified accountId in GetAccountArg does not exist.
        case noAccount
        /// An unspecified error.
        case other

        public var description: String {
            return "\(SerializeUtil.prepareJSONForSerialization(GetAccountErrorSerializer().serialize(self)))"
        }
    }
    public class GetAccountErrorSerializer: JSONSerializer {
        public init() { }
        public func serialize(_ value: GetAccountError) -> JSON {
            switch value {
                case .noAccount:
                    var d = [String: JSON]()
                    d[".tag"] = .str("no_account")
                    return .dictionary(d)
                case .other:
                    var d = [String: JSON]()
                    d[".tag"] = .str("other")
                    return .dictionary(d)
            }
        }
        public func deserialize(_ json: JSON) -> GetAccountError {
            switch json {
                case .dictionary(let d):
                    let tag = Serialization.getTag(d)
                    switch tag {
                        case "no_account":
                            return GetAccountError.noAccount
                        case "other":
                            return GetAccountError.other
                        default:
                            return GetAccountError.other
                    }
                default:
                    fatalError("Failed to deserialize")
            }
        }
    }

    /// The IndividualSpaceAllocation struct
    public class IndividualSpaceAllocation: CustomStringConvertible {
        /// The total space allocated to the user's account (bytes).
        public let allocated: UInt64
        public init(allocated: UInt64) {
            comparableValidator()(allocated)
            self.allocated = allocated
        }
        public var description: String {
            return "\(SerializeUtil.prepareJSONForSerialization(IndividualSpaceAllocationSerializer().serialize(self)))"
        }
    }
    public class IndividualSpaceAllocationSerializer: JSONSerializer {
        public init() { }
        public func serialize(_ value: IndividualSpaceAllocation) -> JSON {
            let output = [ 
            "allocated": Serialization._UInt64Serializer.serialize(value.allocated),
            ]
            return .dictionary(output)
        }
        public func deserialize(_ json: JSON) -> IndividualSpaceAllocation {
            switch json {
                case .dictionary(let dict):
                    let allocated = Serialization._UInt64Serializer.deserialize(dict["allocated"] ?? .null)
                    return IndividualSpaceAllocation(allocated: allocated)
                default:
                    fatalError("Type error deserializing")
            }
        }
    }

    /// Representations for a person's name to assist with internationalization.
    public class Name: CustomStringConvertible {
        /// Also known as a first name.
        public let givenName: String
        /// Also known as a last name or family name.
        public let surname: String
        /// Locale-dependent name. In the US, a person's familiar name is their givenName, but elsewhere, it could be
        /// any combination of a person's givenName and surname.
        public let familiarName: String
        /// A name that can be used directly to represent the name of a user's Dropbox account.
        public let displayName: String
        /// An abbreviated form of the person's name. Their initials in most locales.
        public let abbreviatedName: String
        public init(givenName: String, surname: String, familiarName: String, displayName: String, abbreviatedName: String) {
            stringValidator()(givenName)
            self.givenName = givenName
            stringValidator()(surname)
            self.surname = surname
            stringValidator()(familiarName)
            self.familiarName = familiarName
            stringValidator()(displayName)
            self.displayName = displayName
            stringValidator()(abbreviatedName)
            self.abbreviatedName = abbreviatedName
        }
        public var description: String {
            return "\(SerializeUtil.prepareJSONForSerialization(NameSerializer().serialize(self)))"
        }
    }
    public class NameSerializer: JSONSerializer {
        public init() { }
        public func serialize(_ value: Name) -> JSON {
            let output = [ 
            "given_name": Serialization._StringSerializer.serialize(value.givenName),
            "surname": Serialization._StringSerializer.serialize(value.surname),
            "familiar_name": Serialization._StringSerializer.serialize(value.familiarName),
            "display_name": Serialization._StringSerializer.serialize(value.displayName),
            "abbreviated_name": Serialization._StringSerializer.serialize(value.abbreviatedName),
            ]
            return .dictionary(output)
        }
        public func deserialize(_ json: JSON) -> Name {
            switch json {
                case .dictionary(let dict):
                    let givenName = Serialization._StringSerializer.deserialize(dict["given_name"] ?? .null)
                    let surname = Serialization._StringSerializer.deserialize(dict["surname"] ?? .null)
                    let familiarName = Serialization._StringSerializer.deserialize(dict["familiar_name"] ?? .null)
                    let displayName = Serialization._StringSerializer.deserialize(dict["display_name"] ?? .null)
                    let abbreviatedName = Serialization._StringSerializer.deserialize(dict["abbreviated_name"] ?? .null)
                    return Name(givenName: givenName, surname: surname, familiarName: familiarName, displayName: displayName, abbreviatedName: abbreviatedName)
                default:
                    fatalError("Type error deserializing")
            }
        }
    }

    /// Space is allocated differently based on the type of account.
    public enum SpaceAllocation: CustomStringConvertible {
        /// The user's space allocation applies only to their individual account.
        case individual(Users.IndividualSpaceAllocation)
        /// The user shares space with other members of their team.
        case team(Users.TeamSpaceAllocation)
        /// An unspecified error.
        case other

        public var description: String {
            return "\(SerializeUtil.prepareJSONForSerialization(SpaceAllocationSerializer().serialize(self)))"
        }
    }
    public class SpaceAllocationSerializer: JSONSerializer {
        public init() { }
        public func serialize(_ value: SpaceAllocation) -> JSON {
            switch value {
                case .individual(let arg):
                    var d = Serialization.getFields(Users.IndividualSpaceAllocationSerializer().serialize(arg))
                    d[".tag"] = .str("individual")
                    return .dictionary(d)
                case .team(let arg):
                    var d = Serialization.getFields(Users.TeamSpaceAllocationSerializer().serialize(arg))
                    d[".tag"] = .str("team")
                    return .dictionary(d)
                case .other:
                    var d = [String: JSON]()
                    d[".tag"] = .str("other")
                    return .dictionary(d)
            }
        }
        public func deserialize(_ json: JSON) -> SpaceAllocation {
            switch json {
                case .dictionary(let d):
                    let tag = Serialization.getTag(d)
                    switch tag {
                        case "individual":
                            let v = Users.IndividualSpaceAllocationSerializer().deserialize(json)
                            return SpaceAllocation.individual(v)
                        case "team":
                            let v = Users.TeamSpaceAllocationSerializer().deserialize(json)
                            return SpaceAllocation.team(v)
                        case "other":
                            return SpaceAllocation.other
                        default:
                            return SpaceAllocation.other
                    }
                default:
                    fatalError("Failed to deserialize")
            }
        }
    }

    /// Information about a user's space usage and quota.
    public class SpaceUsage: CustomStringConvertible {
        /// The user's total space usage (bytes).
        public let used: UInt64
        /// The user's space allocation.
        public let allocation: Users.SpaceAllocation
        public init(used: UInt64, allocation: Users.SpaceAllocation) {
            comparableValidator()(used)
            self.used = used
            self.allocation = allocation
        }
        public var description: String {
            return "\(SerializeUtil.prepareJSONForSerialization(SpaceUsageSerializer().serialize(self)))"
        }
    }
    public class SpaceUsageSerializer: JSONSerializer {
        public init() { }
        public func serialize(_ value: SpaceUsage) -> JSON {
            let output = [ 
            "used": Serialization._UInt64Serializer.serialize(value.used),
            "allocation": Users.SpaceAllocationSerializer().serialize(value.allocation),
            ]
            return .dictionary(output)
        }
        public func deserialize(_ json: JSON) -> SpaceUsage {
            switch json {
                case .dictionary(let dict):
                    let used = Serialization._UInt64Serializer.deserialize(dict["used"] ?? .null)
                    let allocation = Users.SpaceAllocationSerializer().deserialize(dict["allocation"] ?? .null)
                    return SpaceUsage(used: used, allocation: allocation)
                default:
                    fatalError("Type error deserializing")
            }
        }
    }

    /// The TeamSpaceAllocation struct
    public class TeamSpaceAllocation: CustomStringConvertible {
        /// The total space currently used by the user's team (bytes).
        public let used: UInt64
        /// The total space allocated to the user's team (bytes).
        public let allocated: UInt64
        public init(used: UInt64, allocated: UInt64) {
            comparableValidator()(used)
            self.used = used
            comparableValidator()(allocated)
            self.allocated = allocated
        }
        public var description: String {
            return "\(SerializeUtil.prepareJSONForSerialization(TeamSpaceAllocationSerializer().serialize(self)))"
        }
    }
    public class TeamSpaceAllocationSerializer: JSONSerializer {
        public init() { }
        public func serialize(_ value: TeamSpaceAllocation) -> JSON {
            let output = [ 
            "used": Serialization._UInt64Serializer.serialize(value.used),
            "allocated": Serialization._UInt64Serializer.serialize(value.allocated),
            ]
            return .dictionary(output)
        }
        public func deserialize(_ json: JSON) -> TeamSpaceAllocation {
            switch json {
                case .dictionary(let dict):
                    let used = Serialization._UInt64Serializer.deserialize(dict["used"] ?? .null)
                    let allocated = Serialization._UInt64Serializer.deserialize(dict["allocated"] ?? .null)
                    return TeamSpaceAllocation(used: used, allocated: allocated)
                default:
                    fatalError("Type error deserializing")
            }
        }
    }


    /// Stone Route Objects

    static let getAccount = Route(
        name: "get_account",
        namespace: "users",
        deprecated: false,
        argSerializer: Users.GetAccountArgSerializer(),
        responseSerializer: Users.BasicAccountSerializer(),
        errorSerializer: Users.GetAccountErrorSerializer(),
        attrs: ["host": "api",
                "style": "rpc"]
    )
    static let getAccountBatch = Route(
        name: "get_account_batch",
        namespace: "users",
        deprecated: false,
        argSerializer: Users.GetAccountBatchArgSerializer(),
        responseSerializer: ArraySerializer(Users.BasicAccountSerializer()),
        errorSerializer: Users.GetAccountBatchErrorSerializer(),
        attrs: ["host": "api",
                "style": "rpc"]
    )
    static let getCurrentAccount = Route(
        name: "get_current_account",
        namespace: "users",
        deprecated: false,
        argSerializer: Serialization._VoidSerializer,
        responseSerializer: Users.FullAccountSerializer(),
        errorSerializer: Serialization._VoidSerializer,
        attrs: ["host": "api",
                "style": "rpc"]
    )
    static let getSpaceUsage = Route(
        name: "get_space_usage",
        namespace: "users",
        deprecated: false,
        argSerializer: Serialization._VoidSerializer,
        responseSerializer: Users.SpaceUsageSerializer(),
        errorSerializer: Serialization._VoidSerializer,
        attrs: ["host": "api",
                "style": "rpc"]
    )
}
