---
title: SACM Information Model
docname: draft-inacio-sacmInfoModel-00
date: 2015-05-21

ipr: trust200902
area: security
wg: SACM Working Group
kw: Internet-Draft
cat: std

coding: us-ascii
pi:
   toc: yes
   sortrefs: yes
   symrefs: yes
   comments: yes

author:
    -
        ins: C. Inacio
        name: Christopher Inacio
        org: Carnegie Mellon University
        # abbrev: CMU
        # street:
        # - 4500 5th Avenue
        # - Pittsburgh, PA 15213
        street: 4500 5th Avenue
        city: Pittsburgh
        code: 15213
        country: United States
        phone: +1-412-268-3098
        email: inacio@cert.org
    -
        ins: H. Birkholz
        name: Henk Birkholz
        org: Fraunhofer Institute
        # street:
        # - some street
        # - some place
        street: unknown
        city: unknown
        code: A12345
        country: Germany
        email: henk.birkholz@sit.fraunhofer.de
    -
        ins: N. Cam-Winget
        name: Nancy Cam-Winget
        org: Cisco, Inc.
        # street:
        # - some street
        # - some place
        street: unknown
        city: unknown
        code: 12345
        country: United States
        email: ncamwing@cisco.com

normative:
  RFC2119:
  RFC2616:
  # I-D.draft-ietf-sacm-architecture-03:
  # I-D.draft-ietf-sacm-requirements-06:

 
informative:
  RFC2782:


entity:
    SELF: "[RFCXXXX]"


--- abstract

This document defines the information model to for the Security Automation and Continous Monitoring (SACM) system.  The information model is divided into multiple components to allow the minimum necessary interoperability between the various SACM components.  SACM components may support multiple data models and may therefore negotiate data exchanges which exceed the information model presented in this document.  This document is intended to ensure a minimum level of interoperability and functionality while allowing enhanced data exchanges using various data models.

--- middle

# Introduction #

The Security Automation and Continous Monitoring working group has defined an architecture **I-D.draft-ietf-sacm-architecture-03** and requirements **I-D.draft-ietf-sacm-requirements-06** necessary to meet the charter of the working group.  The result of the requirements is an information model that ensures interoperability of larger system components provided by multiple vendors supporting multiple data models.  At the same time, the architectural design for the SACM system, in order to provide for scalabity and flexability has separated the various functions needed to implement data collection, data evaluation, and other security functions.  In reaction to those design points the following proposed information model creates multiple layers of information model to define only the necessary exchange of information at the highest architectural levels while deferring as much of the information model as possible to lower layers.  The interoperability requirements, which in effect create the minimal exchangeable data set, create the need to move a minimal set of information elements up further into the various architectural layers.

While this document is focused on the defining an information model, the authors are not ignorant of the necessary layer below the information model of a data model.  While the SACM requirements defines that multiple data models will be supported, this information model creates the need for a basic extensible required data model to ensure minimal interoperability between various vendor provided implementations.  The basic data model may be employed to generate a minimum functioning state defined by the SACM working group, but implementors are free to extend the operation based on new data models as those data models evolve.



# Information Model Components # {#components}


The SACM architecture primarily defines three distinct data flows:  data from posture provider to consumer (the consumer can be either the controller or the posture assessment information consumer) (which will be reffered to as the data exchange), control information to and from the controller to either the posture provider or the posture assessment information consumer (which will be referred to as the control exchange), and control and data from controller to controller (which will be referred to as the federation exchange).[^ci1]

[^ci1]:If anyone has a better name than "federation exchange", I would like to use it.

The information model is focused on implementing the first two exchanges: data exchange and control exchange.  With the definition of those exchanges in place and cognizant of the needs of the federation exchange, the federation exchange is defined to add the necessary capabilities beyond what is provided by the data and control exchanges to enable controller to controller functions.

Creating a system that is designed to allow authentication and authorization and other security functions is challenging in a system which cannot itself establish trust anchors to the the endpoints of those communications.  The reason for a SACM system to exist is to monitor the security posture attributes of the very endpoints which are necessary in establishing the needed trust relationships.  This contradiction cannot be completely resolved and therefore the information model does not attempt to resolve this issue.  The authors make note of this issue here and comment on all security issues in the [Security Issues](#security) section.


# Information Model for the Control Exchange # {#ctrExchng}

The control exchange MUST be provided for using a SACM standardized data model with a minimum protocol requirement to ensure interoperability.  The control exchange MAY be implemented with additional data models and additional protocols, but the standard protocols are still required.  The control exchange provides for the control plane functions of authentication, authorization, entity discovery, capability negotiation, pub/sub distribution, and data proxy/broker support.

Initial discovery of the controller to first connect a SACM endpoint under the purview of a controller are beyond the scope of this information model, but many technologies, such as [DNS SRV][RFC2782] records may be used to discover an appropriate controller.

## Theory of Operation ##

The information model is designed to allow the controller, posture providers, and posture consumers to send a small number of SACM specific exchanges to establish SACM system which can be leveraged using multiple data models and protocols.  The architecture specification requires various functions to be logicaly present within the controller function, this information model makes every effort to ensure that a SACM controller may exist but still leverage enterprise resources to the maximum amount possible.  The desire of the design of this information model is to allow the controller to leverage existing enterprise services (e.g. directory services, authentication, authorization, and audit) to the maximum amount possible.  In the situation where those services are not available from an enterprise service, a SACM controller MUST be able to provide those services.

~~~~
                                 +-------------------------------+
                                 |                               |
                                 |     Posture Consumer          |
                                 |                               |
                                 +-------------------------------+
                                                                  
                                  ^          ^^              ^^   
                                2 |          || 5            ||   
                                  v          vv              ||   
                                                             ||   
                +---------------------------------+          ||   
       6        |                                 |          || 3 
<------------>  |  Controller                     |          ||   
                |                                 |          ||   
                +---------------------------------+          ||   
                                                             ||   
                                  ^          ^^              ||   
                                1 |          || 4            ||   
                                  v          vv              vv   
                                                                  
                                 +-------------------------------+
                                 |                               |
                                 |     Posture Provider          |
                                 |                               |
                                 +-------------------------------+

~~~~
{: #figArch title="Architecture with Communication Exchanges"}

The figure [][#figArch] has the high level architecture diagram from **I-D.draft-ietf-sacm-architecture-03** with a slightly different view of the communications paths drawn.  Each path is labeled with a number 1 -- 6.  The double drawn paths are data exchange paths (3, 4, 5) while the single drawn paths are control exchanges (1 and 2).  Path 6 can be both a control exchange and a data exchange.

The first exchange is the posture provider announcing to the controller its set of capabilities.



## Control Exchange Header Information ##

Every control exchange contains the following pieces of information:

* sender_systemSimpleName --- operator defined common name for a system.  This name should be usable by administrators and analysts and unique within the domain of a single system controller
* sender_systemUID --- a unique ID (possibly formed by a combination of defined system attributes) that can be used within the automation system and is invariant in the life of the endpoint
* destination_systemSimpleName --- operator defined common name for a system.  This name should be usable by administrators and analysts and unique within the domain of a single system controller
* destination_systemUID --- a unique ID (possibly formed by a combination of defined system attributes) that can be used within the automation system and is invariant in the life of the endpoint
* system\_domain --- the unique domain name of the system controller.  The system\_domain creates a single namespace in which the systemSimpleName and systemUID are unique.  Sharing between controllers can maintain the origin of data, separation of namespace, and access control domain.

These five pieces of information prefix every message sent within a single controller domain and identify the endpoints in the message.

## Authentication ##

The information model presented here does not attempt to create a new authentication mechanism, but instead define a simple information exchange procedure that will allow other authentication mechanisms to be used while requiring enough minimum information to be able to create a sufficiently strong exchange that MAY be implemented directly within the controller.

### Auth Request ###

The following information is required in order to begin a authentication request.  The mechanism is designed to have a minimum amount of information without requiring a complex set of security challenges in order to enable machine-to-machine login and automation.

* securityTokenType --- a new code point managed by a new IANA registry
* securityToken --- `binary` blob of a security token

### Token Grant ###

The SACM controller MAY provide fine grained access control to various data and resources.  This is enabled by providing a permission set which is cryptographically protected by the controller.

* envelope --- cryptographic boundary structure
    + securityToken --- `binary` SACM security token
    + permissionSet --- set of permissions the authenticated principal is permitted to access
* HMAC --- cryptographically verifiable wrapper around the envelope [^ci6]


[^ci6]: this could be done using assymetric a real HMAC, but that assumes a PKI infrastructure; otherwise some type of shared secret could be created, etc. all ugly;  I don't want to have SACM own any of that, but rely on an enterprise already having something in place.  Is there a standard way of saying "use your enterprise existing secure messaging"?

## Negotiation and Announcement Control Exchange ##

The negotiation control exchange information is also used to generate the announcement to the controller of an endpoint's existence.  The announcement / negotiation offer message includes the key elements of information necessary for the controller to provide directory information to other endpoints, or a posture producer to negotiate communications with a posture consumer.

### Announcement ###

This is the set of information passed in addition to the control exchange header information in order to negotiate a new data exchange path or to announce an endpoint to the controller.

* capabilities --- an array of data models and protocols that the endpoint is capable of using to communicate
    + offers*
        * entryId --- a unique ID to identify a communication entry
        * dataModel --- this is a code point, using a new IANA registry, for data models supported for use within SACM.  (e.g. IF-MAP, OVAL)[^ci2]
        * transports* --- a list of tuples of transports
            + transportProtocol --- this is a code point, using a new IANA registry, for protocols supported for use within SACM
            + transportPortNumber --- the transport protocol port number for this protocol
        * publishSupport --- boolean statement that this endpoint can support direct publishing of topics using the given protocol
        * subscribeSupport --- boolean statement that this endpoint can support subscription to topics using the given protocol
        * pubSubTopicList*
            + topic --- a topic definition[^ci3]
        * filteringCapability --- a code point defining filter capability per protocol, managed by an IANA registry[^ci4]

[^ci2]: need references
[^ci3]: I'm loathe to just use strings here, but I don't know what else might work
[^ci4]: any thoughts on a workable way to do this?  IANA code points for a query language, or something equally awful?

### Acceptance ###

This is the set of information sent to a client to establish a new data exchange session.[^ci5]

* accept --- a single response determining the opposite parties selection in protocol
    + entryId --- client unique ID for the communication method selected
    + transportProtocol --- the code point for the given protocol
    + transportPort --- the transport port number
    + subscribeTopicList*
        * topic --- a list of topics
    + filter --- the filter construct, see [#filter]
        
The subscribeTopicList and filter MUST NOT be sent except during a request to a posture producer to send publish events to a posture receiver.  A posture receiver that receives a message with a filter when the posture receiver has not announced filtering support for the given protocol MAY ignore the filter statement.

[^ci5]: should sacm assume that whatever other data transport protocol has security included?  And therefore there really isn't anything to this message?  If there is a standard SACM data exchange protocol (almost certainly will have to have some type of minimum existence) then this message is used to establish the authorization to establish a new data flow.

### Filter ### {#filter}

The filter message is used in both control and data exchanges.  In the control exchange the filter message is used during the establishment of the publication/subscribe messages.  During data exchanges, the filter message is used during query operations to do selective data operations.

* filter --- filter definition
    + filterType --- code point for the type of filter present, IANA registry
    + SACMFilter
        * primaryKey --- the primary data key on which to filter, data model path to the primary key
        * operation --- a new code point for the set of allowed operations, managed in an IANA registry
        * comparisonTermType --- the type of the term to compare the primaryKey against, new code point, IANA registry
        * comparisonTerm --- the value or address of the comparison term
        * nthKey*
            + combinationOperation --- type of additional operation, code point, managed in an IANA registry
            + key --- key to filter against
            + operation --- same as the primary key allowed comparison operations
            + comparisonTermType --- the type of the term to compare the key against, new code point, IANA registry
            + comparisonTerm --- the value or address of the comparison term
    + otherFilter --- data model specific filter string

# Information Model for the Data Exchange # {#dataExchng}

Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

# Information Model for the Federation Exchange # {#fedExchng}

Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

# IANA Considerations # {#iana}

This proposes the creation an IANA registry for information model code points with expert review as required in the data model implementation.

# Security Considerations # {#security}

The security of an endpoint cannot be ensured, and therefore, a viable trust anchor cannot be established to ensure non-comprised reporting.  The lack of verifability of data is especially true of endpoints reporting on their own status.  Endpoints which are monitoring other endpoints, such as vulnerability scanners, passive sensors, domain controllers, etc. while still potentially vulnerable to exploit and trust erosion, may possibly be considered as a second trust domain in establishing veracity.  Implementors and users of SACM systems should be aware of the fundamental problem of a compromised system reporting its security status and the lack of ability to protect against such an occurence.


--- back

# Note #

## IANA Code Point Registries ##

* securityTokenType
    + kerberos
    + ??
* dataModel
    + SACM Yang
    + OVAL
    + IF/MAP
* transportProtocol
    + XMPP
    + TAXI
    + IF-MAP(?)
    + HTTP/REST(?)
* filterType
    + SACM
    + data model specific
* operation
    + !=
    + \<
    + \>
    + ==
    + \<=
    + \>=
* comparisonTermType
    + constant string
    + data model address
* filteringCapability
    + none
    + SACM standard filter capable
    + data model specific filter capability
